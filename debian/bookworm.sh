#!/usr/bin/env bash

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

# ---
cat <<'EOF' | sudo tee /etc/apt/sources.list
deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware

deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
deb-src http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware

deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
EOF

sudo apt-get update
sudo apt-get upgrade -y

# ---
sudo apt-get install -y libfuse2
sudo apt-get install -y flatpak
sudo flatpak remote-add --if-not-exists flathub "https://dl.flathub.org/repo/flathub.flatpakrepo"
sudo apt-get install -y gnome-software-plugin-flatpak

# ---
sudo apt-get install -y zsh
sudo chsh -s "/usr/bin/zsh"

# ---

sudo apt-get install -y apt-transport-https
sudo apt-get install -y build-essential
sudo apt-get install -y ca-certificates
sudo apt-get install -y curl
sudo apt-get install -y fd-find
sudo apt-get install -y ffmpeg
sudo apt-get install -y fzf
sudo apt-get install -y gh
sudo apt-get install -y git
sudo apt-get install -y gparted
sudo apt-get install -y gpg
sudo apt-get install -y java-common
sudo apt-get install -y jq
sudo apt-get install -y libnss3-tools
sudo apt-get install -y lsb-release
sudo apt-get install -y maim
sudo apt-get install -y net-tools
sudo apt-get install -y ntfs-3g
sudo apt-get install -y openssh-client
sudo apt-get install -y openssl
sudo apt-get install -y ripgrep
sudo apt-get install -y software-properties-common
sudo apt-get install -y stow
sudo apt-get install -y tmux
sudo apt-get install -y unzip
sudo apt-get install -y vim
sudo apt-get install -y vlc
sudo apt-get install -y wget
sudo apt-get install -y xclip
sudo apt-get install -y xdotool
sudo apt-get install -y xsel
sudo apt-get install -y zip

# ---
sudo apt-get install -y chrome-gnome-shell
sudo apt-get install -y gnome-shell-extensions
sudo apt-get install -y gnome-tweaks
sudo flatpak install -y flathub com.mattjakeman.ExtensionManager

# ---
sudo flatpak install -y flathub it.mijorus.gearlever

# ---
sudo apt-get install -y i3
sudo apt-get install -y dmenu
sudo apt-get install -y rofi
sudo apt-get install -y nitrogen
sudo apt-get install -y policykit-1-gnome

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
wget "https://github.com/fastfetch-cli/fastfetch/releases/download/2.20.1/fastfetch-linux-amd64.deb" -O ./fastfetch-linux-amd64.deb
sudo dpkg -i ./fastfetch-linux-amd64.deb
cd -

# ---
cd "/tmp"
wget "https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.6.0/gcm-linux_amd64.2.6.0.deb" -O ./gcm-linux_amd64.2.6.0.deb
sudo dpkg -i ./gcm-linux_amd64.2.6.0.deb
cd -

# ---
sudo wget "https://packages.sury.org/php/apt.gpg" -O "/etc/apt/trusted.gpg.d/php.gpg"

echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee "/etc/apt/sources.list.d/php.list"

sudo apt update

sudo apt-get install -y --ignore-missing \
  php8.3 php8.3-{cli,common,fpm,mysql,sqlite3,pgsql,zip,gd,mbstring,curl,xml,bcmath,tokenizer,intl,tidy,imagick,mcrypt}

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
sudo install -d /usr/share/postgresql-common/pgdg
sudo curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc
sudo sh -c 'echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
sudo apt update
sudo apt -y install postgresql

# ---
curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
sudo chmod 644 /usr/share/keyrings/redis-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list
sudo apt-get update
sudo apt-get install -y redis
sudo systemctl enable redis-server
sudo systemctl start redis-server

# ---
cd "/tmp"
wget https://github.com/axllent/mailpit/releases/download/v1.21.1/mailpit-linux-amd64.tar.gz -O "./mailpit-linux-amd64.tar.gz"
mkdir -p ./mailpit-linux-amd64
tar -xf ./mailpit-linux-amd64.tar.gz -C ./mailpit-linux-amd64
sudo mv ./mailpit-linux-amd64/mailpit /usr/local/bin/mailpit
rm -rf ./mailpit-linux-amd64
sudo chmod +x /usr/local/bin/mailpit
cd -

cat <<'EOF' | sudo tee /etc/systemd/system/mailpit.service
[Unit]
Description=An email testing tool capturing emails from your application during development.

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
sudo flatpak install -y flathub app.zen_browser.zen

sudo ln -s /var/lib/flatpak/exports/bin/app.zen_browser.zen /usr/local/bin/zen

xdg-mime default app.zen_browser.zen.desktop x-scheme-handler/http
xdg-mime default app.zen_browser.zen.desktop x-scheme-handler/https
xdg-mime default app.zen_browser.zen.desktop text/html
xdg-settings set default-web-browser app.zen_browser.zen.desktop
