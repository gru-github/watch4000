#!/bin/bash

install_dmrwatch4000() {
    sudo install -v -g root -o root -p watch-TG-4000.sh /root
    sudo install -v -g root -o root -p dmrwatch4000.{service,path} /lib/systemd/system
    sudo systemctl enable dmrwatch4000.service
    sudo systemctl enable dmrwatch4000.path
    sudo systemctl start dmrwatch4000.service
    sudo systemctl start dmrwatch4000.path
}

uninstall_dmrwatch4000() {
    sudo systemctl disable dmrwatch4000.path
    sudo systemctl disable dmrwatch4000.service
    sudo systemctl stop dmrwatch4000.path
    sudo systemctl stop dmrwatch4000.service
    sudo rm -vf /root/ watch-TG-4000.sh /lib/systemd/system/dmrwatch4000.{service,path}
}


if ! grep -q " / / rw," /proc/self/mountinfo
then
	echo "Please execute the command 'rpi-rw' first!"
	exit
fi


if [ "$1" = "-u" ]
then
    echo "UNinstalling watch4000 addon for Brandmeister connections"
    uninstall_dmrwatch4000
    echo done
else
    echo "Installing watch4000 addon for Brandmeister connections"
    install_dmrwatch4000
    echo done
fi
