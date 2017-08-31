#!/bin/bash
#---------------------------------------------#
#           _                      _          #
#     _ __ | |__   ___   ___ _ __ (_)_  __    #
#    | '_ \| '_ \ / _ \ / _ \ '_ \| \ \/ /    #
#    | |_) | | | | (_) |  __/ | | | |>  <     #
#    | .__/|_| |_|\___/ \___|_| |_|_/_/\_\    #
#    |_|                                      #
#        Install Vox Populi Environment       #
#---------------------------------------------#

commonInstall() {
  echo "----------------------------------------------------"
  echo "     Instruction Commune aux différentes Vagrant    "
  echo "----------------------------------------------------"
  # Update repository
  apt-get update
  # Change ubuntu Password
  echo "ubuntu:azer" | sudo chpasswd
  # Install Nmap
  apt-get install -y nmap

  echo "this is ${1}"
}

# Fonction: Firewall web
firewallWebAPi() {
  echo "--------------------------------------------"
  echo "     Paramatrage et Activation Firewall     "
  echo "--------------------------------------------"
  ufw allow 22
  ufw allow 80
  ufw allow 443
  ufw --force enable
}

# Fonction: Création des VirtualHost pour l'application Web
virtualHostWebAngular() {
    echo "----------------------------------------------"
    echo "     Création du Virtual Host Moodify_Web     "
    echo "----------------------------------------------"
    echo "<VirtualHost *:80>" > /etc/apache2/sites-available/Moodify_Web.conf
    echo "      ServerAdmin alban@fakeMail.com" >> /etc/apache2/sites-available/Moodify_Web.conf
    echo "      DocumentRoot /var/www/html/moodify" >> /etc/apache2/sites-available/Moodify_Web.conf
    echo "      ServerName www.moodify.com" >> /etc/apache2/sites-available/Moodify_Web.conf
    echo "      ErrorLog ${APACHE_LOG_DIR}/error.log" >> /etc/apache2/sites-available/Moodify_Web.conf
    echo "      CustomLog ${APACHE_LOG_DIR}/access.log combined" >> /etc/apache2/sites-available/Moodify_Web.conf
    echo "      <Directory />" >> /etc/apache2/sites-available/Moodify_Web.conf
    echo "        Options FollowSymLinks" >> /etc/apache2/sites-available/Moodify_Web.conf
    echo "        AllowOverride All" >> /etc/apache2/sites-available/Moodify_Web.conf
    echo "      </Directory>" >> /etc/apache2/sites-available/Moodify_Web.conf
    echo "      <Directory /var/www>" >> /etc/apache2/sites-available/Moodify_Web.conf
    echo "        Options Indexes FollowSymLinks MultiViews" >> /etc/apache2/sites-available/Moodify_Web.conf
    echo "        AllowOverride All" >> /etc/apache2/sites-available/Moodify_Web.conf
    echo "        Order Allow,Deny" >> /etc/apache2/sites-available/Moodify_Web.conf
    echo "        Allow from all" >> /etc/apache2/sites-available/Moodify_Web.conf
    echo "      </Directory>" >> /etc/apache2/sites-available/Moodify_Web.conf
    echo "</VirtualHost>" >> /etc/apache2/sites-available/Moodify_Web.conf
    a2ensite Moodify_Web.conf
    a2dissite 000-default.conf
}

# Fonction: Création des VirtualHost pour l'api
virtualHostApi() {
  echo "----------------------------------------------"
  echo "     Création du Virtual Host Moodify_Api     "
  echo "----------------------------------------------"
  echo "<VirtualHost *:80>" > /etc/apache2/sites-available/Moodify_Api.conf
  echo "      ServerAdmin alban@fakeMail.com" >> /etc/apache2/sites-available/Moodify_Api.conf
  echo "      DocumentRoot /var/www/html/api_moodify/webroot" >> /etc/apache2/sites-available/Moodify_Api.conf
  echo "      ServerName moodify.local" >> /etc/apache2/sites-available/Moodify_Api.conf
  echo "      Redirect permanent / https://moodify.local/" >> /etc/apache2/sites-available/Moodify_Api.conf
  echo "      ErrorLog ${APACHE_LOG_DIR}/error.log" >> /etc/apache2/sites-available/Moodify_Api.conf
  echo "      CustomLog ${APACHE_LOG_DIR}/access.log combined" >> /etc/apache2/sites-available/Moodify_Api.conf
  echo "      <Directory />" >> /etc/apache2/sites-available/Moodify_Api.conf
  echo "        Options FollowSymLinks" >> /etc/apache2/sites-available/Moodify_Api.conf
  echo "        AllowOverride All" >> /etc/apache2/sites-available/Moodify_Api.conf
  echo "      </Directory>" >> /etc/apache2/sites-available/Moodify_Api.conf
  echo "      <Directory /var/www>" >> /etc/apache2/sites-available/Moodify_Api.conf
  echo "        Options Indexes FollowSymLinks MultiViews" >> /etc/apache2/sites-available/Moodify_Api.conf
  echo "        AllowOverride All" >> /etc/apache2/sites-available/Moodify_Api.conf
  echo "        Order Allow,Deny" >> /etc/apache2/sites-available/Moodify_Api.conf
  echo "        Allow from all" >> /etc/apache2/sites-available/Moodify_Api.conf
  echo "      </Directory>" >> /etc/apache2/sites-available/Moodify_Api.conf
  echo "</VirtualHost>" >> /etc/apache2/sites-available/Moodify_Api.conf
  a2ensite Moodify_Api.conf
  a2dissite 000-default.conf
}

##################################################
####################   MAIN   ####################
##################################################
if [ "${1}" = "api" ]; then
  # Instructions communes aux différentes vagrants
  commonInstall

  cd /var/www/html
  # Install Apache2 + Php7 + Php extension - libapache, mysql, intl, mbstring, xml
  apt-get install -y apache2 php libapache2-mod-php php-mysql php-intl php-mbstring php-xml
  # Install Unzip, Git, composer
  apt-get install -y unzip git composer
  # Change User Apache user
  sed -i "s/www-data/ubuntu/g" /etc/apache2/envvars
  # Activation ApacheMod Rewrite
  a2enmod rewrite
  # Paramatrage Firewall
  firewallWebAPi
  # Gestion VHost
  virtualHostApi
  # Récuperation Projet Api + Configuration
  git clone https://github.com/dimsand/api_moodify.git
  composer install
  # Ajout du google api client
  composer require google/apiclient
  composer update
  # retart Apache2
  service apache2 restart

### Entre ICI
elif [ "${1}" = "web" ]; then
  # Instructions communes aux différentes vagrants
  commonInstall

  cd /var/www/html/

  # Installation Apache, npm et dépendances du projet + récupération de l'application
  curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
  apt-get install -y apache2 nodejs build-essential
  git clone https://github.com/ngie-mp/moodify.git && cd moodify
  npm install

  # Gestion VHost
  virtualHostWebAngular
  # retart Apache2
  service apache2 restart

  # Récup projet
  # git clone https://github.com/ngie-mp/moodify.git
  # mv moodify/* .



### ET ICI
elif [ "${1}" = "db" ];then
  # Instructions communes aux différentes vagrants
  commonInstall

  # Paramatrage Firewall
  ufw allow 22
  ufw allow 3306
  ufw --force enable

  # Install Mysql Server
  echo "mysql-server mysql-server/root_password password 0000" | sudo debconf-set-selections
  echo "mysql-server mysql-server/root_password_again password 0000" | sudo debconf-set-selections
  bash -c "DEBIAN_FRONTEND='noninteractive' apt-get -y -q install mysql-server"

  # Initialise Param of the DB and Authorize distant access
  sed -i -e 's/\(bind-address\)/# \1/' /etc/mysql/mysql.conf.d/mysqld.cnf
  echo "UPDATE mysql.user SET Host = '%' WHERE user.Host = 'localhost' AND user.User = 'root';" | mysql -uroot -p0000
  sudo service mysql restart

  # create database cook
  mysql -uroot -p0000 < cook.sql

else
    echo "ERROR: You Try to call an unknow server installation"
    exit 1
fi
