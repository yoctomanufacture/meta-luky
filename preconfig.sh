#!/bin/bash

git clone git://git.yoctoproject.org/poky
cd poky; 
git checkout 9fd145d27ec479668fac490a9f1078089f22bf59; 
cd -;

git clone git://git.openembedded.org/meta-openembedded
cd meta-openembedded; 
git checkout 5b6f39ce325d490fc382d5d59c5b8b9d5fa38b38; 
cd -;

git clone git://git.yoctoproject.org/meta-ivi
cd meta-ivi; 
git checkout 8.0.1; 
cd -;

git clone git://git.yoctoproject.org/meta-raspberrypi
cd meta-raspberrypi; 
git checkout 1350ba8acf4b5bb03b26a00da91a6698d4b7e2da;
cd -

cd ./meta-ivi/meta-ivi/conf
TEMPLATECONF=`pwd`;
export TEMPLATECONF=`echo $TEMPLATECONF`;
echo "templateconf is $TEMPLATECONF";
cd ../../../

#meta-luky

cp -rfpv ./meta-luky/preconfig/files/* ./
#modified:   meta-ivi/conf/distro/poky-ivi-systemd.conf
#modified:   meta-ivi/recipes-yocto-ivi/images/ivi-image.inc
#modified:   meta-ivi/recipes-yocto-ivi/packagegroups/packagegroup-abstract-component-p1.bb
#modified:   meta-ivi/recipes-yocto-ivi/packagegroups/packagegroup-specific-component-p1.bb

CWD=`pwd`
CWD=`echo $CWD | sed 's/\//\\\\\//g'`;

echo "current directory is $CWD ";

sed -i "s/TOBEREPLACED/${CWD}/g" ./build/conf/bblayers.conf

#META-IVI
mv -v  ./meta-ivi/meta-ivi-bsp/recipes-graphics/wayland/weston_1.5.0.bbappend  ./meta-ivi/meta-ivi-bsp/recipes-graphics/wayland/weston_1.5.0.bbapp_disabled
mv -v  ./meta-ivi/meta-ivi/recipes-connectivity/connman/connman_%.bbappend     ./meta-ivi/meta-ivi/recipes-connectivity/connman/connman_%.bbappend_disabled
mv -v  ./meta-ivi/meta-ivi/recipes-connectivity/ofono/ofono_%.bbappend         ./meta-ivi/meta-ivi/recipes-connectivity/ofono/ofono_%.bbappend_disabled
mv -v  ./meta-ivi/meta-ivi/recipes-graphics/wayland/weston_1.5.0.bbappend      ./meta-ivi/meta-ivi/recipes-graphics/wayland/weston_1.5.0.bbappend_disabled

#POKY
mv -v ./poky/meta/recipes-connectivity/connman/connman_1.25.bb	 ./poky/meta/recipes-connectivity/connman/connman_1.25.bb_disabled
mv -v ./poky/meta/recipes-connectivity/ofono/ofono_1.15.bb      ./poky/meta/recipes-connectivity/ofono/ofono_1.15.bb_disabled
mv -v ./poky/meta/recipes-connectivity/ofono/ofono_git.bb       ./poky/meta/recipes-connectivity/ofono/ofono_git.bb_disabled
mv -v ./poky/meta/recipes-graphics/wayland/wayland_1.5.0.bb     ./poky/meta/recipes-graphics/wayland/wayland_1.5.0.bb_disabled
mv -v ./poky/meta/recipes-graphics/wayland/weston_1.5.0.bb      ./poky/meta/recipes-graphics/wayland/weston_1.5.0.bb_disabled

source ./poky/oe-init-build-env ./build
bitbake ivi-image
