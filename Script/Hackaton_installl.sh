#!/bin/bash
#################### Script Memo ####################
#     Création et Configuration du Vagrant File     #
#     Installation apache2, Php7, Activation Ext    #
#     Configuration Envars, Vhost                   #
#     Download Composer, Installation CakePhp       #
#     Paramétrage CakePhp                           #
#####################################################

# test=0
# while [ ${test} -eq 0 ]; do
#   read -s -p "Enter Password for root MySQL: `echo $'\n> '`" SqlPassword
#   echo `echo $'\n '`
#   read -s -p "Confirm Password for root MySQL: `echo $'\n> '`" SqlConfirmPass
#   echo `echo $'\n '`
#   if [ ${SqlPassword} = ${SqlConfirmPass} ]; then
#     test=1
#   fi
# done

### Création du dossier webData ###
if [ ! -d "webData" ]; then
  mkdir webData
else
  rm -R webData && mkdir webData
fi

### Création du dossier sqlData ###
if [ ! -d "sqlData" ]; then
  mkdir sqlData && cp cook.sql sqlData/cook.sql
else
  rm -R sqlData && mkdir sqlData && cp cook.sql sqlData/cook.sql
fi

### Création du dossier apiData ###
if [ ! -d "apiData" ]; then
  mkdir apiData
else
  rm -R apiData && mkdir apiData
fi

### Création du dossier nagiosData ###
if [ ! -d "nagiosData" ]; then
  mkdir nagiosData && cp nagiosautoinstall.sh nagiosData/nagiosautoinstall.sh
else
  rm -R nagiosData && mkdir nagiosData && cp nagiosautoinstall.sh nagiosData/nagiosautoinstall.sh
fi

vagrant box add nagios Nagios.box

### Création du Fichier Vagrantfile
touch Vagrantfile
echo "Vagrant.configure("2") do |config|" > Vagrantfile
echo "  config.vm.define \"web\" do |web|" >> Vagrantfile
echo "    web.vm.box = \"ubuntu/xenial64\"" >> Vagrantfile
echo "    web.vm.network \"private_network\", ip: \"192.168.33.11\"" >> Vagrantfile
echo "    web.vm.synced_folder \"./webData\", \"/var/www/html\"" >> Vagrantfile
echo "    web.vm.provision \"shell\", path: \"https://raw.githubusercontent.com/It-DreamTeam/Vox-Populi/master/Script/serverInstall.sh\", :args => \"'web'\"" >> Vagrantfile
# echo "    web.vm.provision \"shell\", path: \"./serverInstall.sh\", :args => \"'web'\"" >> Vagrantfile
echo "  end" >> Vagrantfile
echo "  config.vm.define \"db\" do |db|" >> Vagrantfile
echo "    db.vm.box = \"ubuntu/xenial64\"" >> Vagrantfile
echo "    db.vm.network \"private_network\", ip: \"192.168.33.12\"" >> Vagrantfile
echo "    db.vm.synced_folder \"./sqlData\", \"/home/ubuntu\"" >> Vagrantfile
echo "    db.vm.provision \"shell\", path: \"https://raw.githubusercontent.com/It-DreamTeam/Vox-Populi/master/Script/serverInstall.sh\", :args => \"'db' '${SqlPassword}'\"" >> Vagrantfile
# echo "    db.vm.provision \"shell\", path: \"./serverInstall.sh\", :args => \"'db'\"" >> Vagrantfile
echo "  end" >> Vagrantfile

echo "  config.vm.define \"api\" do |api|" >> Vagrantfile
echo "    api.vm.box = \"ubuntu/xenial64\"" >> Vagrantfile
echo "    api.vm.network \"private_network\", ip: \"192.168.33.14\"" >> Vagrantfile
echo "    api.vm.synced_folder \"./apiData\", \"/var/www/html\"" >> Vagrantfile
echo "    api.vm.provision \"shell\", path: \"https://raw.githubusercontent.com/It-DreamTeam/Vox-Populi/master/Script/serverInstall.sh\", :args => \"'api' '${SqlPassword}'\"" >> Vagrantfile
# echo "    api.vm.provision \"shell\", path: \"./serverInstall.sh\", :args => \"'api'\"" >> Vagrantfile
echo "  end" >> Vagrantfile
echo "  config.vm.define \"nagios\" do |nagios|" >> Vagrantfile
echo "    nagios.vm.box = \"nagios\"" >> Vagrantfile
echo "    nagios.vm.network \"private_network\", ip: \"192.168.33.13\"" >> Vagrantfile
echo "    nagios.vm.synced_folder \"./nagiosData\", \"/home/ubuntu\"" >> Vagrantfile
echo "  end" >> Vagrantfile
echo "end" >> Vagrantfile

# Lancement de deux vagrant (Web and DB)
vagrant up
