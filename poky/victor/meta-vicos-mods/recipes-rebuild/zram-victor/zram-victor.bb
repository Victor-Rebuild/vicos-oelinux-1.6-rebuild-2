SUMMARY = "save-eye-color, used by engine to save the Rebuild Eyes colors"
DESCRIPTION = "Used by engine to save the Rebuild Eyes colors"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
inherit systemd

SRC_URI += " \
    file://zram-init.service \
"

SYSTEMD_SERVICE:${PN} = "zram-init.service"

S = "${UNPACKDIR}"
#UNPACKDIR = "${S}"

do_install() {
#    install -d ${D}$/etc/default/
    install -d ${D}${systemd_unitdir}/system
#    install -m 0644 ${UNPACKDIR}/zram.conf ${D}$/etc/default/zram
    install -m 0644 ${UNPACKDIR}/zram-init.service ${D}${systemd_unitdir}/system/zram-init.service
}

FILES:${PN} += " \
    ${systemd_unitdir}/system/zram-init.service \
"

RDEPENDS:${PN} = "systemd"
