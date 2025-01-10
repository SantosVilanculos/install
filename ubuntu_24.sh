#!/usr/bin/env bash

# WORKDIR=$(dirname $(realpath "$0"))

# ---
sudo apt-get update
sudo apt-get upgrade -y

# ---
# sudo dpkg --add-architecture i386
# sudo apt-get update
# sudo apt-get dist-upgrade -y

# ---
sudo apt-get install -y zsh
sudo chsh -s "/usr/bin/zsh"

# ---
sudo add-apt-repository universe
sudo apt-get install libfuse2t64
sudo apt-get install -y flatpak
sudo apt-get install -y gnome-software-plugin-flatpak
sudo flatpak remote-add --if-not-exists flathub "https://dl.flathub.org/repo/flathub.flatpakrepo"

# ---
sudo apt-get install -y tmux
# ---

sudo apt-get install -y i3
sudo apt-get install -y nitrogen
sudo apt-get install -y dmenu
sudo apt-get install -y policykit-1-gnome

# ---
sudo apt-get install -y software-properties-common
sudo apt-get install -y build-essential
sudo apt-get install -y git
sudo apt-get install -y gh

sudo apt-get install -y curl
sudo apt-get install -y wget
sudo apt-get install -y zip
sudo apt-get install -y unzip

sudo apt-get install -y ffmpeg
sudo apt-get install -y vlc
sudo apt-get install -y maim

sudo apt-get install -y xsel
sudo apt-get install -y xclip
sudo apt-get install -y libnss3-tools

sudo apt-get install -y gparted
sudo apt-get install -y net-tools
sudo apt-get install -y java-common

sudo apt-get install -y gpg
sudo apt-get install -y jq
sudo apt-get install -y openssl
sudo apt-get install -y ca-certificates

sudo apt-get install -y gnome-tweaks
sudo apt-get install -y gnome-shell-extensions
sudo apt-get install -y chrome-gnome-shell
sudo flatpak install -y flathub com.mattjakeman.ExtensionManager

sudo flatpak install -y flathub it.mijorus.gearlever

# ---
cd "/tmp"

wget "https://github.com/fastfetch-cli/fastfetch/releases/download/2.30.1/fastfetch-linux-amd64.deb" -O ./fastfetch-linux-amd64.deb
sudo dpkg -i ./fastfetch-linux-amd64.deb

cd -

# ---
cd "/tmp"

wget "https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.6.0/gcm-linux_amd64.2.6.0.deb" -O ./gcm-linux_amd64.2.6.0.deb
sudo dpkg -i ./gcm-linux_amd64.2.6.0.deb

cd -

# ---
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# ---
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt-get update
sudo apt-get install -y eza

# ---
cd "/tmp"
wget https://github.com/axllent/mailpit/releases/download/v1.21.1/mailpit-linux-amd64.tar.gz -O "./mailpit-linux-amd64.tar.gz"
mkdir -p ./mailpit-linux-amd64
tar -xf ./mailpit-linux-amd64.tar.gz -C ./mailpit-linux-amd64
sudo mv ./mailpit-linux-amd64/mailpit /usr/local/bin/mailpit
rm -rf ./mailpit-linux-amd64 ./mailpit-linux-amd64.tar.gz
sudo chmod +x /usr/local/bin/mailpit
cd -

cat <<'EOF' | sudo tee /etc/systemd/system/mailpit.service
[Unit]
Description=Mailpit is an email testing tool for developers

[Service]
ExecStart=/usr/local/bin/mailpit
Restart=always
User=root
Group=root

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable mailpit.service
sudo systemctl start mailpit.service

# ---
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update

sudo apt-get install -y --ignore-missing \
    php8.2 php8.2-{cli,common,fpm,mysql,sqlite3,pgsql,zip,gd,mbstring,curl,xml,bcmath,tokenizer,intl,tidy,imagick,mcrypt}

# ---
sudo apt-get install -y apache2 libapache2-mod-php
sudo systemctl enable apache2.service
sudo systemctl start apache2.service
sudo a2enmod rewrite

echo "DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm" | sudo tee /etc/apache2/mods-enabled/dir.conf

sudo systemctl restart apache2.service

# ---
sudo apt-get install -y mariadb-server

sudo sed -i 's/^bind-address\s*=\s*127\.0\.0\.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

sudo systemctl restart mariadb

# ---
sudo flatpak install -y flathub io.github.zen_browser.zen
xdg-mime default zen-browser.desktop x-scheme-handler/http
xdg-mime default zen-browser.desktop x-scheme-handler/https
xdg-mime default zen-browser.desktop text/html
xdg-settings set default-web-browser zen-browser.desktop
