make LDEXPORT="-static -s" clean
make LDEXPORT="-static -s" -j4

zip -9 -r quickjs-$(cat version)-win$(echo ${MSYSTEM:0-2}).zip qjs.exe run-test262.exe
mkdir ./bin
mv qjs.exe qjsc.exe run-test262.exe ./bin
mkdir -p ./lib/quickjs
cp libquickjs.a ./lib/quickjs/libquickjs.d.a
strip -g libquickjs.a
mv libquickjs.a libquickjs.lto.a ./lib/quickjs
mkdir -p ./include/quickjs
cp -p quickjs.h quickjs-libc.h ./include/quickjs
zip -9 -r quickjs-$(cat version)-win$(echo ${MSYSTEM:0-2})-all.zip ./bin ./doc ./examples ./include ./lib Changelog readme.txt TODO VERSION
