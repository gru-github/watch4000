# watch4000
Addon for pi-star running on a DUPLEX (simplex not supported!) hotspot with a Brandmeister server. 
During a running QSO TG4000 calls are not working. This software monitors the logfile for TG4000 events and calls bmapi with dropdyn and dropqso.
Realized by one script and 2 systemd servcices and one path watcher. The latter restarts the watcher service if a change to the pi-star log directory occurs. This might indicate a logfile change.

HOWTO:
BEFORE you install it is reommended, that you backup your SD card.

Installing is easy, login to your ssh console on your raspi running pi-star 4.X:

```
cd /root
git clone https://github.com/gru-github/watch4000
cd watch4000
./install.sh
```

UNinstalling also easy:

```
cd /root/watch4000
./uninstall.sh
```

if you want to remove the cloned git repository:

```
cd /tmp
rm -rf /root/watch4000
```

---------------------------------------------------------------------------

Details:

watch-TG-4000.sh: Script uses tail/grep to check for a line indicating TG4000 use. Uses pistar-bmapi command to dropdyn and dropqso.

dmrwatch4000.service: Enabled service, starts script watch-TG-4000.sh after boot.

dmrwatch4000restart.service: Disabled service, used by path-change events to restart dmrwatch4000.service

dmrwatch4000.path: Enabled, watches for change events on the pi-star logfile directory. Starts dmrwatch4000restart.service

