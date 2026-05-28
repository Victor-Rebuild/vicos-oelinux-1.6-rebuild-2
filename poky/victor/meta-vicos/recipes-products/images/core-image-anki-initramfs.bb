DESCRIPTION = "Small initramfs image based on poky/meta/core-recipes/core-image-minimal-initramfs - directly boots into dm-verity rootfs on emmc."

#PACKAGE_INSTALL = "busybox udev base-passwd ${ROOTFS_BOOTSTRAP_INSTALL} lvm2 initscript-anki rampost"
PACKAGE_INSTALL = "busybox udev base-passwd lvm2 initscript-anki rampost"

# Do not pollute the initrd image with rootfs features
IMAGE_FEATURES = ""

export IMAGE_BASENAME = "core-image-anki-initramfs"
#IMAGE_ROOTFS_DIR = "${WORKDIR}/${IMAGE_BASENAME}-${PV}-${PR}_${PRODUCT}/rootfs"
IMAGE_LINGUAS = ""

LICENSE = "MIT"

IMAGE_FSTYPES = "cpio.gz"
inherit core-image qperf

IMAGE_ROOTFS_SIZE = "8192"

BAD_RECOMMENDATIONS += "busybox-syslog"

do_deploy_initramfs() {
    CPIO_GZ=$(find ${IMGDEPLOYDIR} -name "*.cpio.gz" | head -1)
    if [ -z "$CPIO_GZ" ]; then
        bbfatal "No cpio.gz found in ${IMGDEPLOYDIR}"
    fi
    DEST="${TOPDIR}/tmp-glibc/deploy/images/apq8009-robot-robot-perf"
    install -d ${DEST}
    install -m 0644 ${CPIO_GZ} \
        ${DEST}/core-image-anki-initramfs-apq8009-robot.rootfs.cpio.gz
}
addtask do_deploy_initramfs after do_image_cpio before do_image_complete
do_deploy_initramfs[dirs] = "${TOPDIR}/tmp-glibc/deploy/images/apq8009-robot-robot-perf"