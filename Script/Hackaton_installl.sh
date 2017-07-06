#!/bin/bash
#################### Script Memo ####################
#     Création et Configuration du Vagrant File     #
#     Installation apache2, Php7, Activation Ext    #
#     Configuration Envars, Vhost                   #
#     Download Composer, Installation CakePhp       #
#     Paramétrage CakePhp                           #
#####################################################

# change root mdp via requete sql apres up vagarnt mdp mysql temp in install

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
else

  test=0
  # while [ ${test} -eq 0 ]; do
  #   read -s -p "Enter Password for root MySQL: `echo $'\n> '`" SqlPassword
  #   echo `echo $'\n '`
  #   read -s -p "Confirm Password for root MySQL: `echo $'\n> '`" SqlConfirmPass
  #   echo `echo $'\n '`
  #   if [ ${SqlPassword} = ${SqlConfirmPass} ]; then
  #     test=1
  #   fi
  # done

  ### Création du Fichier Vagrantfile
  touch Vagrantfile
  echo "Vagrant.configure("2") do |config|" > Vagrantfile
  echo "  config.vm.define \"web\" do |web|" >> Vagrantfile
  echo "    web.vm.box = \"ubuntu/xenial64\"" >> Vagrantfile
  echo "    web.vm.network \"private_network\", ip: \"192.168.33.11\"" >> Vagrantfile
  echo "    web.vm.synced_folder \"./data\", \"/var/www/html\"" >> Vagrantfile
  echo "    web.vm.provision \"shell\", path: \"serverInstall.sh\", :args => \"'web'\"" >> Vagrantfile
  echo "  end" >> Vagrantfile
  echo "  config.vm.define \"db\" do |db|" >> Vagrantfile
  echo "    db.vm.box = \"ubuntu/xenial64\"" >> Vagrantfile
  echo "    db.vm.network \"private_network\", ip: \"192.168.33.12\"" >> Vagrantfile
  echo "    db.vm.provision \"shell\", path: \"serverInstall.sh\", :args => \"'db'\"" >> Vagrantfile
  echo "  end" >> Vagrantfile
  echo "end" >> Vagrantfile

  # echo "  config.vm.synced_folder \"./data\", \"/var/www/html\"" >> Vagrantfile
  # echo "  config.vm.provision \"shell\", path: \"https://raw.githubusercontent.com/It-DreamTeam/Vox-Populi/master/Script/serverInstall.sh\"" >> Vagrantfile
  # echo "  config.vm.provision \"shell\", path: \"serverInstall.sh\", :args => \"'${SqlPassword}'\"" >> Vagrantfile
  # echo "  config.vm.provision \"shell\", inline: <<-SHELL" >> Vagrantfile
  # echo "     apt-get update" >> Vagrantfile
  # echo "     apt-get install -y apache2 php php-mysql libapache2-mod-php php-intl unzip composer" >> Vagrantfile
  # echo "  SHELL" >> Vagrantfile
  # echo "end" >> Vagrantfile










# echo "  config.vm.network \"public_network\", ip: \"192.168.1.151\"" >> Vagrantfile



 #  #change mdp mysql
 # ${cmdProxy} echo "SET PASSWORD FOR 'root'@'127.0.0.1' = PASSWORD('${rootPasswd}');
 # SET PASSWORD FOR 'root'@'::1' = PASSWORD('${rootPasswd}');
 # SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${rootPasswd}');" \
 #  | mysql -uroot # host (192.... .11)
 #
 # ${cmdProxy} service mysql restart

fi
