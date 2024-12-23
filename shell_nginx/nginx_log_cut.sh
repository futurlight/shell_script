#! /bin/bash

log_path="/var/log/nginx"
backup_dir="/var/log/nginx/backup"

date_str=$(date +%Y%m%d)

mkdir -p $backup_dir

mv ${log_path}/access.log ${backup_dir}/access.log.$date_str

mv ${log_path}/error.log ${backup_dir}/error.log.$date_str


kill -USR1 $(cat /var/run/nginx.pid)


find $backup_dir -type f -name "*.log.*" -mtime +180 -exec rm {} \;
