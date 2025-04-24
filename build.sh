#
# NOTE
# mingw-w64-i686-headers-git-12.0.0.r619.g850703ae4-1-any.pkg.tar.zst build error:
#
#   multiple definition of `__mingw_fe_pc53_env  fenv.h:76
#   multiple definition of `__mingw_fe_pc64_env' fenv.h:72
#   multiple definition of `__mingw_fe_dfl_env' fenv.h:64
#

rm -f *.exe *.a
make LDEXPORT="-static -s" PREFIX="./build" CONFIG_LTO=y CONFIG_WIN32=y CONFIG_M32=y clean
make LDEXPORT="-static -s" PREFIX="./build" CONFIG_LTO=y CONFIG_WIN32=y CONFIG_M32=y STRIP=strip -j`nproc` install

cp run-test262.exe ./build/bin
cp ./build/lib/quickjs/libquickjs.a ./build/lib/quickjs/libquickjs.d.a
strip -g ./build/lib/quickjs/libquickjs.a
cp -r Changelog readme.txt TODO VERSION ./doc ./examples ./build
cd ./build
zip -9 -j quickjs-$(cat version)-win$(echo ${MSYSTEM:0-2}).zip ./bin/*
zip -9 -r quickjs-$(cat version)-win$(echo ${MSYSTEM:0-2})-all.zip ./bin ./doc ./examples ./include ./lib Changelog readme.txt TODO VERSION
cd ..
