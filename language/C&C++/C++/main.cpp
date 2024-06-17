#include <iostream>
#include <map>
using namespace std;

// 基类，产品注册模板接口类
// 模板参数 ProductType_t 表示的类是产品抽象类
template <class ProductType_t>
class IProductRegistrar
{
public:
    // 获取产品对象抽象接口
    virtual ProductType_t *CreateProduct() = 0;

protected:
    // 禁止外部构造和析构, 子类的"内部"的其他函数可以调用
    IProductRegistrar() {}
    virtual ~IProductRegistrar() {}

private:
    // 禁止外部拷贝和赋值操作
    IProductRegistrar(const IProductRegistrar &);
    const IProductRegistrar &operator=(const IProductRegistrar &);
};

// 工厂模板类，用于获取和注册产品对象
// 模板参数 ProductType_t 表示的类是产品抽象类
template <class ProductType_t>
class ProductFactory
{
public:
    // 获取工厂单例，工厂的实例是唯一的
    static ProductFactory<ProductType_t> &Instance()
    {
        static ProductFactory<ProductType_t> instance;
        return instance;
    }

    // 产品注册
    void RegisterProduct(IProductRegistrar<ProductType_t> *registrar, std::string name)
    {
        m_ProductRegistry[name] = registrar;
    }

    // 根据名字name，获取对应具体的产品对象
    ProductType_t *GetProduct(std::string name)
    {
        // 从map找到已经注册过的产品，并返回产品对象
        if (m_ProductRegistry.find(name) != m_ProductRegistry.end())
        {
            return m_ProductRegistry[name]->CreateProduct();
        }

        // 未注册的产品，则报错未找到
        std::cout << "No product found for " << name << std::endl;

        return NULL;
    }

private:
    // 禁止外部构造和虚构
    ProductFactory() {}
    ~ProductFactory() {}

    // 禁止外部拷贝和赋值操作
    ProductFactory(const ProductFactory &);
    const ProductFactory &operator=(const ProductFactory &);

    // 保存注册过的产品，key:产品名字 , value:产品类型
    std::map<std::string, IProductRegistrar<ProductType_t> *> m_ProductRegistry;
};

// 产品注册模板类，用于创建具体产品和从工厂里注册产品
// 模板参数 ProductType_t 表示的类是产品抽象类（基类），ProductImpl_t 表示的类是具体产品（产品种类的子类）
template <class ProductType_t, class ProductImpl_t>
class ProductRegistrar : public IProductRegistrar<ProductType_t>
{
public:
    // 构造函数，用于注册产品到工厂，只能显示调用
    explicit ProductRegistrar(std::string name)
    {
        // 通过工厂单例把产品注册到工厂
        ProductFactory<ProductType_t>::Instance().RegisterProduct(this, name);
    }
    ~ProductRegistrar() {std::cout << "~ProductRegistrar" << std::endl;};

    // 创建具体产品对象指针
    ProductType_t *CreateProduct()
    {
        return new ProductImpl_t();
    }
};
// 协议抽象类
class IProtocol
{
public:
    virtual void communicate() = 0;
    IProtocol() {};
    virtual ~IProtocol() {};
};

// 协议具体类
class ProtocolA : public IProtocol
{
public:
    void communicate() override
    {
        cout << "I am communicate A" << endl;
    }

    ProtocolA() {std::cout << "ProtocolA" << std::endl;};
    ~ProtocolA() {std::cout << "~ProtocolA" << std::endl;};
};

class ProtocolB : public IProtocol
{
public:
    void communicate() override
    {
        cout << "I am communicate B" << endl;
    }

    ProtocolB() {std::cout << "ProtocolB" << std::endl;};
    ~ProtocolB() {std::cout << "~ProtocolB" << std::endl;}
};

class ProtocolC : public IProtocol
{
public:
    void communicate() override
    {
        cout << "I am communicate C" << endl;
    }

    ProtocolC() {std::cout << "ProtocolC" << std::endl;};
    ~ProtocolC() {std::cout << "~ProtocolC" << std::endl;}
};

// ProtocolA的注册类
class ProtocolARegistrar : public ProductRegistrar<IProtocol, ProtocolA>
{
public:
    ProtocolARegistrar() : ProductRegistrar("ProtocolA") {}
};

// ProtocolB的注册类
class ProtocolBRegistrar : public ProductRegistrar<IProtocol, ProtocolB>
{
public:
    ProtocolBRegistrar() : ProductRegistrar("ProtocolB") {}
};

// 主函数
int main()
{

    // 预先注册协议
    ProtocolARegistrar regA;
    ProtocolBRegistrar regB;
    auto protocalC = new ProductRegistrar<IProtocol, ProtocolC>("ProtocolC");

    // 获取协议对象并调用
    IProtocol *protocolA = ProductFactory<IProtocol>::Instance()
                              .GetProduct("ProtocolA");
    protocolA->communicate();

    IProtocol *ProtocolC = ProductFactory<IProtocol>::Instance()
                              .GetProduct("ProtocolC");
    ProtocolC->communicate();

    IProtocol *ProtocolB = ProductFactory<IProtocol>::Instance()
                              .GetProduct("ProtocolB");
    ProtocolB->communicate();

    protocalC->~ProductRegistrar();

    return 0;
}