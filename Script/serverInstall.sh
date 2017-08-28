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
echo "ubuntu:azer" | sudo chpasswd

# Install common for Web and DB server
apt-get install -y nmap
echo ${1}
if [ "${1}" = "web" ]; then
  cd /var/www/html
  # rootPasswd= ${1}

  # Install Apache2 + Php7 + Php extension - libapache, mysql, intl, mbstring, xml
  apt-get install -y apache2 php libapache2-mod-php php-mysql php-intl php-mbstring php-xml

  # Install Unzip, Git, composer
  apt-get install -y unzip git composer

  # Install CakePhp
  composer create-project --prefer-dist cakephp/app moodify
  cd moodify
  chmod +x ./bin/cake

  # Paramatrage Firewall
  ufw allow 22
  ufw allow 80
  ufw allow 443
  ufw --force enable

  # Add Certificat SSL
  openssl genrsa -out moodify.local.key 2048
  openssl req -new -x509 -key moodify.local.key -out moodify.local.cert -days 3650 -subj /CN=moodify.local
  mkdir /etc/apache2/sites-available/Ultimate
  mv moodify.local.key /etc/apache2/sites-available/Ultimate/moodify.local.key
  mv moodify.local.cert /etc/apache2/sites-available/Ultimate/moodify.local.cert


  composer require google/apiclient
  composer update

  rm -r config src webroot README.md composer.json
  git init
  git remote add origin https://github.com/It-DreamTeam/Vox-Populi-Application.git
  git pull origin master

  # Change User Apache user
  sed -i "s/www-data/ubuntu/g" /etc/apache2/envvars
  # sed -i "s//www\/html\/moodify\/webroot/g" /etc/apache2/sites-available/000-default.conf
  a2enmod rewrite

  # Gestion Vhost
  echo "<VirtualHost *:80>" > /etc/apache2/sites-available/Ultimate.conf
  echo "      ServerAdmin alban@fakeMail.com" >> /etc/apache2/sites-available/Ultimate.conf
  echo "      DocumentRoot /var/www/html/moodify/webroot" >> /etc/apache2/sites-available/Ultimate.conf
  echo "      ServerName moodify.local" >> /etc/apache2/sites-available/Ultimate.conf
  echo "      Redirect permanent / https://moodify.local/" >> /etc/apache2/sites-available/Ultimate.conf
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
  echo "<VirtualHost *:443>" >> /etc/apache2/sites-available/Ultimate.conf
  echo "      ServerAdmin alban@fakeMail.com" >> /etc/apache2/sites-available/Ultimate.conf
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
  echo "      # adding custom SSL cert" >> /etc/apache2/sites-available/Ultimate.conf
  echo "      SSLEngine on" >> /etc/apache2/sites-available/Ultimate.conf
  echo "      SSLCertificateFile /etc/apache2/sites-available/Ultimate/moodify.local.cert" >> /etc/apache2/sites-available/Ultimate.conf
  echo "      SSLCertificateKeyFile /etc/apache2/sites-available/Ultimate/moodify.local.key" >> /etc/apache2/sites-available/Ultimate.conf
  echo "</VirtualHost>" >> /etc/apache2/sites-available/Ultimate.conf
  a2ensite Ultimate.conf
  a2dissite 000-default.conf
  a2enmod ssl

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

# elif [ "${1}" = "nagios" ];then
#   # Install Nagios 3
#   export DEBIAN_FRONTEND="noninteractive"
#
#   sudo debconf-set-selections <<< "nagios3-cgi nagios3/adminpassword password 0000"
#   sudo debconf-set-selections <<< "nagios3-cgi nagios3/adminpassword-repeat password 0000"
#
#   sudo apt-get install -y nagios3
fi
