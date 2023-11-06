#!/bin/bash

# Update and upgrade system 
sudo apt update && sudo apt upgrade -y

read -p "Finish update and upgrade. Press enter to continue"

# Setup system clock synchronized 
# check if it's runing 
systemctl is-active --quiet systemd-timesyncd && echo "systemd-timesyncd is active" || (sudo apt install systemd-timesyncd && sudo systemctl start systemd-timesyncd && echo "systemd-timesyncd is active")

sleep 5


echo "System clock synchronized should be yes"
timedatectl

read -p "Finish clock synchronized, Press enter to continue"

# non-free software 
# Check if apt repositories exists
if ! [ -x "$(command -v apt-add-repository)" ]; then
  echo 'Error: apt-add-repository is not installed.' >&2
  sleep 3
  echo "Install apt-add-repository"
  sudo apt install software-properties-common
  exit 1
fi

echo "See List enabled repositories"
apt-add-repository --list

read -p "Only main and non-free-firmware, Press enter to continue"

echo "Start enable repositories that's makes you run non free software (contrib, non-free)"
sleep 2
sudo apt-add-repository contrib non-free
read -p "Finish from enable repositories, Press enter to continue"

echo "Update & upgrade again"
sleep 2
sudo apt update && sudo apt upgrade -y
read -p "Finish from update && upgrade, Press enter to continue"

echo "Install VLC and Codecs"
sleep 2
sudo apt install libavcodec-extra gstreamer1.0-libav gstreamer1.0-plugins-ugly gstreamer1.0-vaapi vlc

read -p "Finish installing VLC and codecs, Press enter to continue"

echo "Install rar support"
sleep 2
sudo apt install rar unrar

read -p "Finish installing rar support, Press enter to continue"

echo "Install Microsoft Fonts and alternatives for (Cambria, Calibri)"
sleep 2
sudo apt install ttf-mscorefonts-installer fonts-crosextra-caladea fonts-crosextra-carlito


read -p "Finish installing Microsoft Fonts, Press enter to continue"

echo "Install and Enable Firewall"
sleep 2
sudo apt install gufw
sleep 2
echo "enable firewall"
sudo ufw enable
read -p "Finish Install and Enable Firewall, Press enter to continue"

echo "Install apps for system informaion (htop, neofetch)"
sleep 2
sudo apt install htop neofetch
read -p "Finish Install apps, Press enter to continue"

echo "Install && Enable Flatpak Support"
sleep 2
sudo apt install flatpak
sleep 2
echo "Enable Flathub"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
