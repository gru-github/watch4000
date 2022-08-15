# watch4000
Addon for pi-star running on a DUPLEX (simplex not supported!) hotspot with a Brandmeister server. 
During a running QSO TG4000 calls are not working. This software monitors the logfile for TG4000 events and calls bmapi with dropdyn and dropqso.
Realized by one script and 2 systemd servcices and one path watcher.

Howto:
Installing is easy, login to your ssh console on your raspi running pi-star 4.X:

cd /root
git clone https://github.com/gru-github/watch4000
cd watch4000
./install.sh

UNinstalling also easy:

cd /root/watch4000
./uninstall.sh

if you want to remove the cloned git repository:

cd /tmp
rm -rf /root/watch4000
