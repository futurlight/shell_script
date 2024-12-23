#! bin/sh

#创建repo
cat > /etc/yum.repos.d/nginx.repo << EOF
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=0
enable=1
EOF
#部署nginx并设置自动启动
yum -y install nginx
systemctl enable nginx
systemctl start nginx
#调整防火墙策略
firewall-cmd --permanent --zone=public --add-port=80/tcp
firewall-cmd --reload

#验证nginx
nginx -v

