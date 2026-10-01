#!/bin/bash
LOG=~/monitor/connection_log.txt

while true; do
  # --- YOUR EXISTING CHECKS START HERE ---
  for domain in google.com youtube.com github.com web.whatsapp.com whatsapp.com; do
    if ping -c1 -W3 $domain > /dev/null; then
      echo "$(date '+%Y-%m-%d %H:%M:%S') $domain UP" | tee -a $LOG
    else
      echo "$(date '+%Y-%m-%d %H:%M:%S') $domain DOWN!!!" | tee -a $LOG
    fi
  done
  # --- YOUR EXISTING CHECKS END HERE ---

  sleep 300
done
