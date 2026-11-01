SUMMARY = "zram"
DESCRIPTION = "zram for vectr"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
inherit systemd

SRC_URI += " \
    file://zram-init.service \
"

SYSTEMD_SERVICE:${PN} = "zram-init.service"

S = "${UNPACKDIR}"

do_install() {
    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${UNPACKDIR}/zram-init.service ${D}${systemd_unitdir}/system/zram-init.service
}

FILES:${PN} += " \
    ${systemd_unitdir}/system/zram-init.service \
"

RDEPENDS:${PN} = "systemd"
