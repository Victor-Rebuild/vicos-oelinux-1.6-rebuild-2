# Camera Open Source packages
include ${BASEMACHINE}/${BASEMACHINE}-anki-robot-image.inc
require include/mdm-bootimg.inc

ROOTFS_POSTPROCESS_COMMAND += ' read_only_robot_rootfs_hook; set_root_shell_zsh;'

# A hook function to support read-only-rootfs IMAGE_FEATURES
read_only_robot_rootfs_hook () {
	if [ -e ${IMAGE_ROOTFS}/etc/default/ssh ]; then
		echo 'SYSCONFDIR=/data/ssh' > ${IMAGE_ROOTFS}/etc/default/ssh
	fi
	echo "ro.anki.product.name=${ANKI_PRODUCT_NAME}" >> ${IMAGE_ROOTFS}/build.prop
}

# Change root shell to zsh
set_root_shell_zsh() {
	if [ -f ${IMAGE_ROOTFS}/etc/passwd ]; then
		sed -i 's|^\(root:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:\)/bin/sh$|root:\1/bin/zsh|' ${IMAGE_ROOTFS}/etc/passwd
	fi
}