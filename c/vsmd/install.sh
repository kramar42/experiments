#!/bin/sh

install -o root -g users -m 755 vsmd /usr/bin/
install -o root -g users -m 755 vsmctl /usr/bin/
install -o root -g users -m 644 vsmd.conf /etc/
install -o root -g users -m 644 start-vsmd.conf /etc/init/

kill -1 1
