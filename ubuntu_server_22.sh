#!/usr/bin/env bash

# ---
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove -y
sudo apt-get autoclean -y
sudo apt-get clean -y
sudo service packagekit restart

# ---
sudo apt-get install -y tmux software-properties-common build-essential git curl wget zip unzip net-tools

# ---
cd "/tmp"
wget "https://github.com/fastfetch-cli/fastfetch/releases/download/2.20.1/fastfetch-linux-amd64.deb" -O ./fastfetch-linux-amd64.deb
sudo dpkg -i ./fastfetch-linux-amd64.deb
cd -

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
sudo mkdir -p /var/www/laravel
echo "<?php phpinfo();" | sudo tee /var/www/laravel/index.php
sudo chown -R www-data:www-data /var/www/laravel
sudo chmod -R 755 /var/www/laravel

# ---
cat <<'EOF' | sudo tee /etc/apache2/sites-available/laravel.conf
<VirtualHost *:80>
    DocumentRoot /var/www/laravel

    <Directory /var/www/laravel>
            Options -Indexes +FollowSymLinks +MultiViews
            AllowOverride All
            Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/laravel.error.log
    CustomLog ${APACHE_LOG_DIR}/laravel.custom.log combined
</VirtualHost>
EOF

sudo a2dissite 000-default.conf
sudo a2ensite laravel.conf
sudo systemctl restart apache2

# ---
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw allow 3306
sudo ufw --force enable
