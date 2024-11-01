#!/usr/bin/bash

# ---
# WORKDIR=$(dirname $(realpath "$0"))

# ---
sudo apt-get purge -y ace-of-penguins
sudo apt-get purge -y aisleriot
sudo apt-get purge -y five-or-more
sudo apt-get purge -y four-in-a-row
sudo apt-get purge -y gbrainy
sudo apt-get purge -y gnome-2048
sudo apt-get purge -y gnome-chess
sudo apt-get purge -y gnome-klotski
sudo apt-get purge -y gnome-mahjongg
sudo apt-get purge -y gnome-mines
sudo apt-get purge -y gnome-nibbles
sudo apt-get purge -y gnome-robots
sudo apt-get purge -y gnome-sudoku
sudo apt-get purge -y gnome-sushi
sudo apt-get purge -y gnome-taquin
sudo apt-get purge -y gnome-tetravex
sudo apt-get purge -y gnomine
sudo apt-get purge -y hitori
sudo apt-get purge -y iagno
sudo apt-get purge -y lightsoff
sudo apt-get purge -y mahjongg
sudo apt-get purge -y pegsolitaire
sudo apt-get purge -y quadrapassel
sudo apt-get purge -y swell-foop
sudo apt-get purge -y tali

sudo apt-get autoremove -y
sudo apt-get autoclean -y
sudo apt-get clean -y
sudo service packagekit restart

sudo apt-get update
sudo apt-get upgrade -y

sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get dist-upgrade -y

# ---
sudo apt-get install -y software-properties-common
sudo apt-get install -y gpg
sudo apt-get install -y build-essential
sudo apt-get install -y curl
sudo apt-get install -y wget
sudo apt-get install -y zip
sudo apt-get install -y unzip
sudo apt-get install -y git
sudo apt-get install -y gh
sudo apt-get install -y ffmpeg
sudo apt-get install -y vlc
sudo apt-get install -y maim
sudo apt-get install -y xsel
sudo apt-get install -y xclip
sudo apt-get install -y libnss3-tools
sudo apt-get install -y jq
sudo apt-get install -y openssl
sudo apt-get install -y ca-certificates

cd "/tmp"
wget "https://github.com/fastfetch-cli/fastfetch/releases/download/2.28.0/fastfetch-linux-amd64.deb" -O "./fastfetch-linux-amd64.deb"
sudo dpkg -i "./fastfetch-linux-amd64.deb"
cd -

sudo apt install -y flatpak
sudo apt install -y gnome-software-plugin-flatpak
sudo flatpak remote-add --if-not-exists flathub "https://dl.flathub.org/repo/flathub.flatpakrepo"

# ---
sudo apt-get install -y zsh

source "$HOME/.bashrc"

sudo chsh -s $(which zsh)

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# ---
sudo flatpak install -y flathub it.mijorus.gearlever
