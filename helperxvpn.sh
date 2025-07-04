#!/bin/bash
# HELPERXVPN AUTO INSTALLER | Author: HELPER

# Root check
if [ "${EUID}" -ne 0 ]; then
  echo "❌ Please run as root!"
  exit 1
fi

# Virtualization check
if [ "$(systemd-detect-virt)" == "openvz" ]; then
  echo "❌ OpenVZ is not supported!"
  exit 1
fi

# Update & packages
apt update -y && apt upgrade -y
apt install -y wget curl sudo gnupg2 lsb-release software-properties-common build-essential nano

# Directories
mkdir -p /etc/xray /etc/v2ray /var/lib/helperxvpn
touch /etc/xray/domain
touch /etc/v2ray/scdomain
touch /var/lib/helperxvpn/ipvps.conf

# Dummy domain
echo "127.0.0.1" > /etc/xray/domain
echo "127.0.0.1" > /etc/v2ray/scdomain
echo "IP=127.0.0.1" > /var/lib/helperxvpn/ipvps.conf

# Python 2.7 install
cd /usr/src
wget https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz
tar xzf Python-2.7.18.tgz
cd Python-2.7.18
./configure --enable-optimizations
make altinstall

# Set python default
update-alternatives --install /usr/bin/python python /usr/local/bin/python2.7 1
update-alternatives --set python /usr/local/bin/python2.7

# Done
echo ""
echo "✅ HelperXVPN Base Installer Complete!"
echo "👨‍💻 Author: HELPER"
echo "🌐 VPS IP: $(curl -s ifconfig.me)"
echo ""
