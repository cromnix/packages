#!/bin/bash

updpkgsums

makepkg -od

folder=$(find src -maxdepth 1 -type d -name 'linux-*')
path=$(readlink -f $PWD)

cp config ${path}/${folder}/.config
pushd ${path}/${folder}
make olddefconfig
popd
cp ${path}/${folder}/.config config

sed -i "s|CONFIG_LOCALVERSION=.*|CONFIG_LOCALVERSION=\"-cromnix-stable\"|g" ./config
sed -i "s|CONFIG_LOCALVERSION_AUTO=.*|CONFIG_LOCALVERSION_AUTO=n|" ./config

updpkgsums

rm -rf src
