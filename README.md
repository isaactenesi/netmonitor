# Isaac-T Network Monitor

A lightweight production-grade network monitor running on WSL2 (Ubuntu) with systemd, nginx, and logrotate. Built to debug ISP/CGNAT issues in Gweru, ZW.

### Live Demo
`http://localhost/monitor.html` auto-refreshes every 2s from `connection_log.txt`

### Stack
- **Checker**: Bash + curl/ping for L3/L4/L7 checks
- **Daemon**: systemd service `netmonitor.service`
- **Web**: nginx on :80 serving `/home/isaac/monitor`
- **Rotation**: logrotate daily / 5M, 7 days retention
- **Domains**: google.com, youtube.com, github.com, web.whatsapp.com, whatsapp.com

### How it works
1. `check_and_alert.sh` loops every 300s
2. Logs `TIMESTAMP DOMAIN UP/DOWN` to `connection_log.txt`
3. nginx serves `monitor.html` which fetches the log via JS
4. logrotate archives to `connection_log.txt.1.gz`

### Install
```bash
# clone
git clone https://github.com/Isaac-T/netmonitor.git ~/monitor
cd ~/monitor
chmod +x check_and_alert.sh

# systemd
sudo cp netmonitor.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now netmonitor.service

# nginx
sudo apt install nginx -y
sudo nano /etc/nginx/sites-available/default
# set root /home/isaac/monitor; add autoindex on
sudo nginx -t && sudo systemctl restart nginx

# logrotate
sudo cp logrotate.conf /etc/logrotate.d/netmonitor
