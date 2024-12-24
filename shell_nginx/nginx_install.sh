#! bin/bash

echo "          /\\"
echo "         /  \\"
echo "        /    \\"
echo "       /      \\"
echo "      /        \\"
echo "     /          \\"
echo "    /            \\"
echo "   /              \\"
echo "  /                \\"
echo " /                  \\"
echo "/____________________\\"
echo " \___________________/"


#yum部署
yumcreate() {
    releasever=$(cat /etc/redhat-release | awk '{if (/CentOS/) {print "centos"} else if (/Red Hat/) {print "rhel"}}')
    releasever_num=$(cat /etc/redhat-release | grep -oE '[0 - 9]+' | tr -d '[:space:]')


     basearch=$(uname -i)
    cat > /etc/yum.repos.d/nginx.repo << EOF
[nginx]
nane=nginx repo
baseurl=http://nginx.org/packages/$releasever/$releasever_num/$basearch/
gpgcheck=0
enabled-1
EOF
    yum -y install nginx > /dev/null
    systemctl enable nginx > /dev/null
    systemctl start nginx > /dev/null
    firewall-cmd --permanent --zone=public --add-port=80/tcp > /dev/null
    firewall-cmd --reload > /dev/null
    clear
    echo "部署成功"
    
}
#apt部署
aptcreate() {
    sudo apt update -y  > /dev/null
    sudo apt - get install ca - certificates lsb - release gnupg2 -y  > /dev/null
if [ -f /etc/os - release ]; then
    if [ "$ID" = "debian" ]; then
       echo "deb http://nginx.org/packages/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/ $(lsb_release -cs) nginx" | sudo tee /etc/apt/sources.list.d/nginx.list > /dev/null
       sudo wget -qO - https://nginx.org/keys/nginx_signing.key | sudo apt - key add - > /dev/null
    else
        echo "deb http://nginx.org/packages/ubuntu/ $(lsb_release -cs) nginx" | sudo tee /etc/apt/sources.list.d/nginx.list > /dev/null
        sudo wget -qO - https://nginx.org/keys/nginx_signing.key | sudo apt - key add - > /dev/null
    fi
fi
 

 sudo apt update -y > /dev/null
 sudo apt install nginx  -y > /dev/null
 sudo systemctl start nginx  > /dev/null
 sudo systemctl enable nginx  > /dev/null
 clear
 echo "安装成功"
}




while true; do
    clear
    echo -e "${YELLOW}请选择以下选项：${NC}"
    echo -e "  ${GREEN}1.YUM部署nginx${NC}"
    echo -e "  ${GREEN}2. apt部署nginx${NC}"
    echo -e "  ${RED}0. 退出${NC}"

    read -p "请输入你的选择: " choice

    case $choice in
        1)
            function_yumcreate
            break
            ;;
        2)
            aptcreate
            break
            ;;
        0)
            echo -e "${RED}正在退出...${NC}"
            break
            ;;
        *)
            echo -e "${RED}无效的选择，请重新输入。${NC}"
            sleep 2
            ;;
    esac
    read -p "按任意键继续... " -n 1 -s
done





