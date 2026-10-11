SYSTEMD_SERVICE:${PN} = ""

do_install:append() {
    rm -f ${D}${systemd_system_unitdir}/zram-swap.service
    rm -f ${D}${systemd_system_unitdir}/zram.service
}
