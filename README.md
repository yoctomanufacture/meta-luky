This README file contains information on the contents of the
luky layer.

Please see the corresponding sections below for details.


Dependencies
============

This layer depends on:

  URI: git://git.yoctoproject.org/poky
  git checkout 9fd145d27ec479668fac490a9f1078089f22bf59;

  URI: git://git.openembedded.org/meta-openembedded 
  git checkout 5b6f39ce325d490fc382d5d59c5b8b9d5fa38b38;

  URI: git://git.yoctoproject.org/meta-ivi
  git checkout 8.0.1;

  URI: git://git.yoctoproject.org/meta-raspberrypi

Patches
=======

Please submit any patches against the luky layer to the
the maintainer:

Maintainer: Łukasz Czapliński <lczaplinski@o2.pl>


Table of Contents
=================

  I. Adding the luky layer to your build
 II. Misc


I. Adding the luky layer to your build
=================================================

In order to use this layer, you need to make the build system aware of
it.

Assuming the luky layer exists at the top-level of your
yocto build tree, you can add it to the build system by adding the
location of the luky layer to bblayers.conf, along with any
other layers needed. e.g.:

BBLAYERS ?= " \
  TOBEREPLACED/poky/meta \
  TOBEREPLACED/poky/meta-yocto \
  TOBEREPLACED/poky/meta-yocto-bsp \
  TOBEREPLACED/poky/../meta-openembedded/meta-oe \
  TOBEREPLACED/poky/../meta-ivi/meta-ivi \
  TOBEREPLACED/poky/../meta-ivi/meta-ivi-bsp \
  TOBEREPLACED/poky/../meta-raspberrypi \
  TOBEREPLACED/poky/../meta-luky \
  "

II. Misc - IMPORTANT
========

Wayland/Weston wasn't included into build configuration

Adjust files in ./recipes-overlay/rpioverlay/rpioverlay-0.1/files/etc/ directory
according to your network configuration.

It was assumed that wifi dongle is Mono Price rtl8188 for other models further
modifications will be necessary.

After customisation to make Raspberry PI build automatically run . ./meta-luky/preconfig.sh
(tar.gz, ext3 , rpi-sdimg)

