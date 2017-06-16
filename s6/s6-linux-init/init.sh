#!/bin/bash
mkdir -pv ./s6-init-temp/etc/s6
/usr/bin/s6-linux-init-maker \
	-b "/usr/bin" \
	-l "/run/s6" \
	-c "/etc/s6/init" \
	-2 "/etc/s6/rc.init.openrc" \
	-Z "/etc/s6/rc.tini" \
	-3 "/etc/s6/rc.shutdown" \
	-p "/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin" \
	./s6-init-temp/etc/s6/init
