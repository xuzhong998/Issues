```sh
emcc minilzo_func_export.c minilzo-2.06/minilzo.c -o lzo_export.js

emcc -Os --no-entry minilzo_func_export.c minilzo-2.06/minilzo.c -o lzo_export.wasm -s TOTAL_MEMORY=33554432 -s EXPORTED_FUNCTIONS="['_malloc','_free','_add','_lzo1x_decompress_func']"
```

