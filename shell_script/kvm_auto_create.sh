#!/bin/sh

egrep -c '(vmx|svm)' /proc/cpuinfo > /dev/null

if [ $? -eq 1 ]; then
    echo "你的服务器不支持硬件虚拟化"
    exit 1
fi

echo "可进行安装KVM，先进行包资源更新，请先告诉我你要使用的资源包：  
1、apt
2、yum
3、dnf
"

read bag_name

bag_name_list=(
'apt' 'yum' 'dnf'
)


# 验证用户输入
if ! [[ "$bag_name" =~ ^[1-3]$ ]]; then
    echo "无效的输入，请输入1、2或3。"
    exit 1
fi


case $bag_name in 
	1)
		sudo apt update -y
		sudo apt install qemu qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager -y
		;;
	2)
		sudo yum update -y
		sudo yum install qemu qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager -y
		;;
	3)
		sudo dnf update -y
		sudo dnf install @virtualization  -y
		sudo dnf install virt-manager -y
		;;
	*)
		echo "未知错误。"
		exit 1
		;;
esac

echo "资源包更新完毕"
