#
# This file was derived from the 'Hello World!' example recipe in the
# Yocto Project Development Manual.
#

DESCRIPTION = "Luky collections overlay for RPI configuration"
SECTION = "rpioverlay"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
PR = "r0"

SYSTEMD_SERVICE_${PN} = "network@wlan0.service"
SYSTEMD_SERVICE_${PN} = "sshdgenkeys.service"
SYSTEMD_SERVICE_${PN} = "sshd@.service"

S = "${WORKDIR}"
#B = "${FILE_DIRNAME}/rpioverlay-0.1/files/lib/firmware/rtlwifi"

do_compile() {
}

do_install() {
     install -d ${D}${sysconfdir}
     install -d ${D}${sysconfdir}/wpa_supplicant
     install -m 0755 ${FILE_DIRNAME}/rpioverlay-0.1/files/etc/wpa_supplicant/wpa_supplicant-wlan0.conf ${D}${sysconfdir}/wpa_supplicant/
     install -d ${D}${sysconfdir}/systemd/system
     install -m 0755 ${FILE_DIRNAME}/rpioverlay-0.1/files/lib/systemd/system/network@wlan0.service ${D}${sysconfdir}/systemd/system/
}

do_deploy[sstate-outputdirs] = "${DEPLOY_DIR_IMAGE}"

FILES_${PN} += "${base_libdir}/firmware/*"

IMAGE_PREPROCESS_COMMAND += "rpioverlay_image_preprocess"

rpioverlay_image_preprocess () {
    install -m 0755 ${FILE_DIRNAME}/rpioverlay-0.1/files/bcm2835-bootfiles/cmdline.txt ${DEPLOY_DIR_IMAGE}/bcm2835-bootfiles/
}

do_deploy() {
    install -d ${D}${base_libdir}/lib/firmware
    if [ -e ${D}${base_libdir}/firmware ]; then
	     install -d ${D}${base_libdir}/lib/firmware/rtlwifi
	     install -m 0755 ${B}/rtl8188eufw.bin ${D}${base_libdir}/firmware/rtlwifi/rtl8188eufw.bin
    fi
#	     install -d ${D}${base_libdir}/firmware
#	     install -d ${D}${base_libdir}/firmware/rtlwifi
#	     install -m 0755 ${B}/rtl8188eufw.bin ${D}${base_libdir}/firmware/rtlwifi/rtl8188eufw.bin
}

addtask deploy before do_package after do_install

# do_rootfs() { }

inherit update-alternatives systemd

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "network@wlan0.service"

DEPENDS_append = " ${@bb.utils.contains('DISTRO_FEATURES','systemd','systemd-systemctl-native','',d)}"
pkg_postinst_${PN} () {
		systemctl enable network@wlan0.service
		systemctl start network@wlan0.service
		systemctl start sshdgenkeys.service
}
