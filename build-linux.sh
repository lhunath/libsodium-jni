#!/bin/bash -ev

. ./setenv.sh

./submodule-update.sh

export LIBSODIUM_FULL_BUILD="true"

gradle generateSWIGsource --full-stacktrace
gradle build --full-stacktrace

pushd jni
./jnilib.sh
popd

sudo cp ./libsodium/libsodium-host/lib/libsodium.so /usr/lib
mvn -q clean install
./singleTest.sh

#./build-kaliumjni.sh
#./build-libsodiumjni.sh
