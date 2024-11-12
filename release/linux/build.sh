#!/bin/sh

# export VERSION='0.0.0'

if [ -z "$VERSION" ]; then
    echo "Env: VERSION is empty!"
    exit -1
fi

echo "Build for version $VERSION"

# setup
rm -rf target
mkdir target
rm -rf output
mkdir output

build_package() {

    # parms
    type=$1
    arch=$2

    # work dir
    mkdir -p ./target/$type/$arch

    # package source
    mkdir ./target/$type/$arch/package_root
    install -D -m 0755 ./input_files/chargerwalletd_linux_$arch ./target/$type/$arch/package_root/usr/bin/chargerwalletd
    install -D -m 0644 ./chargerwallet.rules ./target/$type/$arch/package_root/lib/udev/rules.d/50-chargerwallet.rules
    install -D -m 0644 ./chargerwalletd.service ./target/$type/$arch/package_root/usr/lib/systemd/system/chargerwalletd.service
    cd ./target/$type/$arch/package_root
    rm -f ../chargerwallet-bridge-$VERSION-$arch.tar.xz
    tar -c -J -f ../chargerwallet-bridge-$VERSION-$arch.tar.xz ./usr ./lib
    cd ../../../../

    # package build
    if [ "$type" = "deb" ]; then
        type_options='--deb-compression xz'
    fi

    if [ "$type" = "rpm" ]; then
        type_options='--rpm-compression xz'
    fi

    fpm \
        -s tar \
        -t $type \
        -a $arch \
        -n chargerwallet-bridge \
        -v $VERSION \
        -d systemd \
        -p chargerwallet-bridge-$VERSION-$arch.$type \
        $type_options \
        --license "LGPL-3.0" \
        --vendor "Lyfeloop Inc." \
        --description "Communication daemon for Chargerwallet Devices" \
        --maintainer "ChargerWallet <dev@chargerwallet.com>" \
        --url "https://chargerwallet.com/" \
        --category "Productivity/Security" \
        --before-install ./fpm.before-install.sh \
        --after-install ./fpm.after-install.sh \
        --before-upgrade ./fpm.before-remove.sh \
        --after-upgrade ./fpm.after-install.sh \
        --before-remove ./fpm.before-remove.sh \
        --after-remove ./fpm.after-remove.sh \
        ./target/$type/$arch/chargerwallet-bridge-$VERSION-$arch.tar.xz

    mv chargerwallet-bridge-$VERSION-$arch.$type ./output/
}

# main
build_package "deb" "amd64"
build_package "deb" "i386"
build_package "deb" "arm64"
build_package "deb" "armhf"
build_package "deb" "arm"

build_package "rpm" "amd64"
build_package "rpm" "i386"
build_package "rpm" "arm64"
build_package "rpm" "armhf"
build_package "rpm" "arm"

# cleanup
rm -rf target
