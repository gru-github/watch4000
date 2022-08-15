#!/bin/bash
#GERU 10-Aug-22 watch log file for TG4000 unlink events
#example logfile line:
#M: 2022-08-08 11:38:23.458 DMR Slot 2, received RF voice header from DF9FZ to TG 4000
#
#
#
while :
do
  logFile=$(ls -t /var/log/pi-star/MMDVM-*.log|head -1)
  if [ -n "$logFile" ];then break;fi
  logger "$0: no logfile found, waiting..."
  sleep 60 #just to prevent too busy looping
done

logger "$0: watching now logfile '$logFile'"
tail -n 0 -f  $logFile|grep --line-buffered 'received RF voice header from.*to TG 4000'|(
  while :
  do
    read line
    if [ -z "$line" ];then exit;fi
#    echo "LINE='$line'"
    timeSlot=$(echo "$line"|sed 's/^.*DMR Slot \(.\), received RF voice header from \([^ ]*\) to TG 4000/\1/')
    case $timeSlot in
      1)
        logger "TG4000/TS1 dropdyn/dropqso occured"
        pistar-bmapi dropdyn 1
        pistar-bmapi dropqso 1
    ;;
      2)
        logger "TG4000/TS2 dropdyn/dropqso occured"
        pistar-bmapi dropdyn 2
        pistar-bmapi dropqso 2
    ;;
    *)
      #nothing of interest found ;-)
    ;;
    esac
  done
)
