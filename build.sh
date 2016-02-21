#!/bin/bash

set -ev

if uname -a | grep -q -i darwin; then
    echo "do nothing"
else
    . ./setenv.sh
fi

rm -rf libsodium

git submodule init
git submodule update

pushd libsodium

git fetch && git checkout stable
./autogen.sh
./configure 
make && make check 
make install

./dist-build/android-arm.sh
./dist-build/android-armv7-a.sh
./dist-build/android-mips32.sh
./dist-build/android-x86.sh

popd

