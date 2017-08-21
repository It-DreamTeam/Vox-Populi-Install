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

# Update repository
apt-get update

# Install common for Web and DB server
apt-get install -y nmap
echo ${1}
if [ "${1}" = "web" ]; then
  cd /var/www/html
  # rootPasswd= ${1}

  # Install Apache2 + Php7 + Php extension - libapache, mysql, intl, mbstring
  apt-get install -y apache2 php libapache2-mod-php php-mysql php-intl php-mbstring

  # Install Unzip, Git,
  apt-get install -y unzip git

  # Install Composer
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
  php composer-setup.php
  php -r "unlink('composer-setup.php');"
  # mv composer.phar /usr/local/bin/composer

  # Install CakePhp
  php composer.phar create-project --prefer-dist cakephp/app moodify
  chmod +x ./moodify/bin/cake
  php composer.phar require google/apiclient
  php composer.phar update

  # Change User Apache user
  sed -i "s/www-data/ubuntu/g" /etc/apache2/envvars
  # sed -i "s/www\/html/www\/html\/moodify\/webroot/g" /etc/apache2/sites-available/000-default.conf
  a2enmod rewrite


  # Gestion Vhost
  echo "<VirtualHost *:80>" > /etc/apache2/sites-available/Ultimate.conf
  echo "      ServerAdmin webmaster@localhost" >> /etc/apache2/sites-available/Ultimate.conf
  echo "      DocumentRoot /var/www/html/moodify/webroot" >> /etc/apache2/sites-available/Ultimate.conf
  echo "      ErrorLog ${APACHE_LOG_DIR}/error.log" >> /etc/apache2/sites-available/Ultimate.conf
  echo "      CustomLog ${APACHE_LOG_DIR}/access.log combined" >> /etc/apache2/sites-available/Ultimate.conf
  echo "      <Directory />" >> /etc/apache2/sites-available/Ultimate.conf
  echo "        Options FollowSymLinks" >> /etc/apache2/sites-available/Ultimate.conf
  echo "        AllowOverride All" >> /etc/apache2/sites-available/Ultimate.conf
  echo "      </Directory>" >> /etc/apache2/sites-available/Ultimate.conf
  echo "      <Directory /var/www>" >> /etc/apache2/sites-available/Ultimate.conf
  echo "        Options Indexes FollowSymLinks MultiViews" >> /etc/apache2/sites-available/Ultimate.conf
  echo "        AllowOverride All" >> /etc/apache2/sites-available/Ultimate.conf
  echo "        Order Allow,Deny" >> /etc/apache2/sites-available/Ultimate.conf
  echo "        Allow from all" >> /etc/apache2/sites-available/Ultimate.conf
  echo "      </Directory>" >> /etc/apache2/sites-available/Ultimate.conf
  echo "</VirtualHost>" >> /etc/apache2/sites-available/Ultimate.conf
  a2ensite Ultimate.conf
  a2dissite 000-default.conf

  # retart Apache2
  service apache2 restart

  # Parameter webserver for cake PHP et récupération des fichiers
  # cd moodify
  # rm -r config
  # rm -r src
  # rm -r webroot
  # git init
  # git remote add origin https://github.com/It-DreamTeam/Vox-Populi-Application.git
  # git pull origin master

elif [ "${1}" = "db" ];then
  # Install Mysql Server
  echo "mysql-server mysql-server/root_password password 0000" | sudo debconf-set-selections
  echo "mysql-server mysql-server/root_password_again password 0000" | sudo debconf-set-selections
  bash -c "DEBIAN_FRONTEND='noninteractive' apt-get -y -q install mysql-server"

  # create database cook

fi
