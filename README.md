# Server Installation

## 1. Basic setup
**Links:**
- https://www.digitalocean.com/community/tutorials/ersteinrichtung-des-servers-mit-ubuntu-18-04-de

### 1.1 Add user
```shell
adduser <username>

usermod -aG sudo <username>
```

### 1.2 Update OpenSSH port
```shell
nano /etc/ssh/sshd_config
```

**/etc/ssh/sshd_config**

```conf
Port <port>
PermitRootLogin no
```

```shell
service sshd restart
```

### 1.3 Update UFW
```shell
ufw allow 65342
ufw enable
```

### 1.4 Update server
```shell
sudo apt update && sudo apt upgrade -y
```

### 1.5 Change hostname
```shell
sudo hostnamectl set-hostname <hostname>
```

### 1.6 Restart server

## 2. user configs and programs
### 2.1 Add .bash_aliases
### 2.2 Install vim and vim-themes
### 2.3 Install tmux
### 2.4 Edit ssh motd
```shell
nano /etc/motd
```

## 3. Install programs
- zip

## 4. Setup webserver & DB

### 4.1 Install webserver
```shell
sudo apt install apache2
sudo apt install php
sudo apt install php-pear php7.2-dev php7.2-zip php7.2-curl php7.2-gd php7.2-mysql php7.2-xml libapache2-mod-php7.2
sudo apt-get -y install gcc make autoconf libc-dev pkg-config
sudo apt-get -y install libmcrypt-dev
sudo pecl install mcrypt-1.0.1

# create virtual hosts

# enable mod_rewrite
sudo a2enmod rewrite
sudo a2enmod actions

# enable ssl
sudo a2enmod ssl

# remove server information 
sudo nano /etc/apache2/conf-enabled/security.conf

ServerTokens Minimal
ServerSignature Off
```

**Enable http2:** https://www.howtoforge.com/how-to-enable-http-2-in-apache/

### 4.2 Install DB
```shell
sudo apt install mysql-server
sudo mysql_secure_installation
sudo apt install phpmyadmin php-mbstring php-gettext
sudo phpenmod mbstring
sudo systemctl restart apache2

# enable .htaccess
sudo nano /etc/apache2/conf-available/phpmyadmin.conf
# add following line after 'DirectoryIndex index.php'
AllowOverride All

# add .htaccess
sudo nano /usr/share/phpmyadmin/.htaccess
# add content
AuthType Basic
AuthName "Restricted Files"
AuthUserFile /etc/phpmyadmin/.htpasswd
Require valid-user
# add .htpasswd
sudo htpasswd -c /etc/phpmyadmin/.htpasswd <username>
```

## 5. Add domain and SSL-Certificate
```shell
sudo add-apt-repository ppa:certbot/certbot
sudo apt install python-certbot-apache
```

## 6. Install GitLab
**Links:**
- https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-gitlab-on-ubuntu-18-04

```shell
sudo apt install ca-certificates curl openssh-server postfix

cd /tmp
curl -LO https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh
sudo bash /tmp/script.deb.sh

sudo apt install gitlab-ce

# change config
sudo nano /etc/gitlab/gitlab.rb

# add virtualhost

# enable mods
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2enmod headers
```

## 7. Install Nextcloud
```shell
# create folder for subdomain and navigate to it
wget https://download.nextcloud.com/server/installer/setup-nextcloud.php

# create virtualhost for subdomain and navigate to url in browser

# copy old files to <nextcloud_data_folder>/<username>/files

# navigate to nextcloud-web-folder
sudo -u www-data php occ files:scan --all
```

## 8. Install mail-server
**Links:**
- https://www.linuxbabe.com/mail-server/setup-basic-postfix-mail-sever-ubuntu

**Config:**
```
IMAP: STARTTLS/143
SMTP: STARTTLS/587
```

# Tutorials
- Update phpMyAdmin - https://devanswers.co/manually-upgrade-phpmyadmin/
- Backup & Restore GitLab - https://medium.com/gits-apps-insight/migrating-gitlab-to-another-server-990092c5179
