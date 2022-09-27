# 记录VSCode配置ESP IDF到最后python virtual environment 错误解决:

在配置VSCode的扩展件ESP IDF的时候, 最后一步python virtual environment遇到以下错误:

```sh
Command failed: "x:/Software/Espressif/python_env/idf4.3_py3.8_env/Scripts/python.exe" -m pip install --upgrade --no-warn-script-location  -r "c:\Users\userName\.vscode\extensions\espressif.esp-idf-extension-1.4.0\requirements.txt"
WARNING: Retrying (Retry(total=4, connect=None, read=None, redirect=None, status=None)) after connection broken by 'SSLError(SSLEOFError(8, 'EOF occurred in violation of protocol (_ssl.c:1125)'))': /simple/gcovr/
WARNING: Retrying (Retry(total=3, connect=None, read=None, redirect=None, status=None)) after connection broken by 'SSLError(SSLEOFError(8, 'EOF occurred in violation of protocol (_ssl.c:1125)'))': /simple/gcovr/
WARNING: Retrying (Retry(total=2, connect=None, read=None, redirect=None, status=None)) after connection broken by 'SSLError(SSLEOFError(8, 'EOF occurred in violation of protocol (_ssl.c:1125)'))': /simple/gcovr/
WARNING: Retrying (Retry(total=1, connect=None, read=None, redirect=None, status=None)) after connection broken by 'SSLError(SSLEOFError(8, 'EOF occurred in violation of protocol (_ssl.c:1125)'))': /simple/gcovr/
WARNING: Retrying (Retry(total=0, connect=None, read=None, redirect=None, status=None)) after connection broken by 'SSLError(SSLEOFError(8, 'EOF occurred in violation of protocol (_ssl.c:1125)'))': /simple/gcovr/
ERROR: Could not find a version that satisfies the requirement gcovr
ERROR: No matching distribution found for gcovr
Command failed: "X:/Software/Espressif/python_env/idf4.3_py3.8_env/Scripts/python.exe" -m pip install --upgrade --no-warn-script-location  -r "c:\Users\userName\.vscode\extensions\espressif.esp-idf-extension-1.4.0\requirements.txt"
```

以及

```sh
Could not fetch URL https://pypi.org/simple/gcovr/: There was a problem confirming the ssl certificate: HTTPSConnectionPool(host='pypi.org', port=443): Max retries exceeded with url: /simple/gcovr/ (Caused by SSLError(SSLEOFError(8, 'EOF occurred in violation of protocol (_ssl.c:1125)'))) - skipping
```

思来想去应该是连接不到国外的源

换源之:

1. 关闭VSCode, 打开安装ESP的目录如下

```sh
X:\Software\Espressif\python_env\idf4.3_py3.8_env\Scripts
```

2. cmd运行activate.bat, **换源**, 运行deactivate.bat

```sh
activate.bat
pip config set global.index-url http://pypi.douban.com/simple/ 
deactivate.bat
```

​	运行结果如下

```sh
X:\Software\Espressif\python_env\idf4.3_py3.8_env\Scripts>activate.bat

(idf4.3_py3.8_env) X:\Software\Espressif\python_env\idf4.3_py3.8_env\Scripts>pip config set global.index-url http://pypi.douban.com/simple/
Writing to C:\Users\userName\AppData\Roaming\pip\pip.ini

(idf4.3_py3.8_env) X:\Software\Espressif\python_env\idf4.3_py3.8_env\Scripts>deactivate.bat
```

3. 重新打开VSCode, 默认按键F1新建工程, 等待VSCode扩展件检查, 期间还可能遇到以下问题

```sh
"X:/Software/Espressif/python_env/idf4.3_py3.8_env/Scripts/python.exe" -m pip install --upgrade --no-warn-script-location -r "c:\Users\userName\.vscode\extensions\espressif.esp-idf-extension-1.4.0\esp_debug_adapter\requirements.txt"
Looking in indexes: http://pypi.douban.com/simple/
Ignoring typing: markers 'python_version < "3.5"' don't match your environment
Requirement already satisfied: setuptools>=21 in d:\software\espressif\python_env\idf4.3_py3.8_env\lib\site-packages (from -r c:\Users\userName\.vscode\extensions\espressif.esp-idf-extension-1.4.0\esp_debug_adapter\requirements.txt (line 1)) (51.3.3)
WARNING: The repository located at pypi.douban.com is not a trusted or secure host and is being ignored. If this repository is available via HTTPS we recommend you use HTTPS instead, otherwise you may silence this warning and allow it anyway with '--trusted-host pypi.douban.com'.
Requirement already satisfied: click in d:\software\espressif\python_env\idf4.3_py3.8_env\lib\site-packages (from -r c:\Users\userName\.vscode\extensions\espressif.esp-idf-extension-1.4.0\esp_debug_adapter\requirements.txt (line 3)) (8.1.3)
WARNING: The repository located at pypi.douban.com is not a trusted or secure host and is being ignored. If this repository is available via HTTPS we recommend you use HTTPS instead, otherwise you may silence this warning and allow it anyway with '--trusted-host pypi.douban.com'.
WARNING: The repository located at pypi.douban.com is not a trusted or secure host and is being ignored. If this repository is available via HTTPS we recommend you use HTTPS instead, otherwise you may silence this warning and allow it anyway with '--trusted-host pypi.douban.com'.
ERROR: Could not find a version that satisfies the requirement psutil>=5.5.1 (from versions: none)
ERROR: No matching distribution found for psutil>=5.5.1
```

错误中发现是命令执行发生的

```sh
"X:/Software/Espressif/python_env/idf4.3_py3.8_env/Scripts/python.exe" -m pip install --upgrade --no-warn-script-location -r "c:\Users\userName\.vscode\extensions\espressif.esp-idf-extension-1.4.0\esp_debug_adapter\requirements.txt"
```

看来应该是豆瓣源里没有这个资源, 于是更换一个阿里云源试试(若是其他的源也找不到那就再更换国内的其他源), 在刚才的命令行中运行以下命令,:

```sh
activate.bat
"X:/Software/Espressif/python_env/idf4.3_py3.8_env/Scripts/python.exe" -m pip install --upgrade --no-warn-script-location -r "c:\Users\userName\.vscode\extensions\espressif.esp-idf-extension-1.4.0\esp_debug_adapter\requirements.txt" -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
deactivate.bat
```

以下是执行结果

```sh
Looking in indexes: http://mirrors.aliyun.com/pypi/simple/
Ignoring typing: markers 'python_version < "3.5"' don't match your environment
Requirement already satisfied: setuptools>=21 in d:\software\espressif\python_env\idf4.3_py3.8_env\lib\site-packages (from -r c:\Users\userName\.vscode\extensions\espressif.esp-idf-extension-1.4.0\esp_debug_adapter\requirements.txt (line 1)) (51.3.3)
Collecting setuptools>=21
  Downloading http://mirrors.aliyun.com/pypi/packages/3e/83/e206edff58159a927c76bbfeef1bf8b39cb12bbb32ae3c6227deb16d0121/setuptools-64.0.0-py3-none-any.whl (1.2 MB)
     ---------------------------------------- 1.2/1.2 MB 1.2 MB/s eta 0:00:00
Requirement already satisfied: click in d:\software\espressif\python_env\idf4.3_py3.8_env\lib\site-packages (from -r c:\Users\userName\.vscode\extensions\espressif.esp-idf-extension-1.4.0\esp_debug_adapter\requirements.txt (line 3)) (8.1.3)
Collecting psutil>=5.5.1
  Downloading http://mirrors.aliyun.com/pypi/packages/b2/ad/65e2b2b97677f98d718388dc11b2a9d7f177ebbae5eef72547a32bc28911/psutil-5.9.1-cp38-cp38-win_amd64.whl (246 kB)
     ---------------------------------------- 246.8/246.8 kB 1.2 MB/s eta 0:00:00
Requirement already satisfied: pygdbmi<=0.9.0.2 in d:\software\espressif\python_env\idf4.3_py3.8_env\lib\site-packages (from -r c:\Users\userName\.vscode\extensions\espressif.esp-idf-extension-1.4.0\esp_debug_adapter\requirements.txt (line 5)) (0.9.0.2)
Collecting pywin32>=227
  Downloading http://mirrors.aliyun.com/pypi/packages/4d/33/251aacef6d983476e4176e3c9b542f60c34735c034392e73762e699e9a5c/pywin32-304-cp38-cp38-win_amd64.whl (12.3 MB)
     ---------------------------------------- 12.3/12.3 MB 1.3 MB/s eta 0:00:00
Requirement already satisfied: requests>=2.21.0 in d:\software\espressif\python_env\idf4.3_py3.8_env\lib\site-packages (from -r c:\Users\userName\.vscode\extensions\espressif.esp-idf-extension-1.4.0\esp_debug_adapter\requirements.txt (line 7)) (2.28.0)
Collecting requests>=2.21.0
  Downloading http://mirrors.aliyun.com/pypi/packages/ca/91/6d9b8ccacd0412c08820f72cebaa4f0c0441b5cda699c90f618b6f8a1b42/requests-2.28.1-py3-none-any.whl (62 kB)
     ---------------------------------------- 62.8/62.8 kB 674.4 kB/s eta 0:00:00
Collecting xmlrunner>=1.7.7
  Downloading http://mirrors.aliyun.com/pypi/packages/57/c0/a19e29bc6038a56bb690549573af6ea11a9d2a5c07aff2e27ed308c2cab9/xmlrunner-1.7.7.tar.gz (5.6 kB)
  Preparing metadata (setup.py) ... done
Requirement already satisfied: colorama in d:\software\espressif\python_env\idf4.3_py3.8_env\lib\site-packages (from click->-r c:\Users\userName\.vscode\extensions\espressif.esp-idf-extension-1.4.0\esp_debug_adapter\requirements.txt (line 3)) (0.4.4)
Requirement already satisfied: idna<4,>=2.5 in d:\software\espressif\python_env\idf4.3_py3.8_env\lib\site-packages (from requests>=2.21.0->-r c:\Users\userName\.vscode\extensions\espressif.esp-idf-extension-1.4.0\esp_debug_adapter\requirements.txt (line 7)) (3.3)
Requirement already satisfied: urllib3<1.27,>=1.21.1 in d:\software\espressif\python_env\idf4.3_py3.8_env\lib\site-packages (from requests>=2.21.0->-r c:\Users\userName\.vscode\extensions\espressif.esp-idf-extension-1.4.0\esp_debug_adapter\requirements.txt (line 7)) (1.26.9)
Requirement already satisfied: charset-normalizer<3,>=2 in d:\software\espressif\python_env\idf4.3_py3.8_env\lib\site-packages (from requests>=2.21.0->-r c:\Users\userName\.vscode\extensions\espressif.esp-idf-extension-1.4.0\esp_debug_adapter\requirements.txt (line 7)) (2.0.12)
Requirement already satisfied: certifi>=2017.4.17 in d:\software\espressif\python_env\idf4.3_py3.8_env\lib\site-packages (from requests>=2.21.0->-r c:\Users\userName\.vscode\extensions\espressif.esp-idf-extension-1.4.0\esp_debug_adapter\requirements.txt (line 7)) (2022.5.18.1)
Building wheels for collected packages: xmlrunner
  Building wheel for xmlrunner (setup.py) ... done
  Created wheel for xmlrunner: filename=xmlrunner-1.7.7-py3-none-any.whl size=6235 sha256=43b6fc21ec503430e530d65c7c473a647e0d36bfd062d3f02c2cf2317e84bc66
  Stored in directory: c:\users\userName\appdata\local\pip\cache\wheels\60\ba\96\a2b8a41b87d4fd0c1a10371c90f2714cca6985c782b77cd44a
Successfully built xmlrunner
Installing collected packages: xmlrunner, pywin32, setuptools, requests, psutil
  Attempting uninstall: setuptools
    Found existing installation: setuptools 51.3.3
    Uninstalling setuptools-51.3.3:
      Successfully uninstalled setuptools-51.3.3
  Attempting uninstall: requests
    Found existing installation: requests 2.28.0
    Uninstalling requests-2.28.0:
      Successfully uninstalled requests-2.28.0
Successfully installed psutil-5.9.1 pywin32-304 requests-2.28.1 setuptools-64.0.0 xmlrunner-1.7.7
```

看来是成功

重新打开VSCode , F1新建ESP IDF工程看看应该以及成功了

PS: 要取消换源使用以下命令

```sh
pip config unset global.index-url
```

设置阿里云源使用以下命令

```sh
pip config set global.index-url http://mirrors.aliyun.com/pypi/simple/
```

