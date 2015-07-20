IMAGE_INSTALL = "packagegroup-core-boot-genivi ${ROOTFS_PKGMANAGE_BOOTSTRAP} ${CORE_IMAGE_EXTRA_INSTALL}"

EXTRA_IMAGE_FEATURES = "debug-tweaks"
EXTRA_IMAGEDEPENDS += "qemu-native qemu-helper-native"

IMAGE_LINGUAS = " "

LICENSE = "MIT"

inherit core-image buildhistory

#IMAGE_ROOTFS_SIZE = "8192"
IMAGE_ROOTFS_SIZE = "2457600"

MACHINE_DISPLAY_WIDTH_PIXELS = "640"
MACHINE_DISPLAY_HEIGHT_PIXELS = "480"

IMAGE_FEATURES += " package-management"

# Create SD image symlink correctly
IMAGE_POSTPROCESS_COMMAND_imx53qsb += "rename_symlink ; "

BUILDHISTORY_COMMIT = "1"

# Set default password for 'root' user
inherit extrausers
ROOTPASSWORD = "rpir"
ROOTUSERNAME = "root"
EXTRA_USERS_PARAMS = "usermod -P ${ROOTPASSWORD} ${ROOTUSERNAME};"
