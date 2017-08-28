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

### Création du Fichier Vagrantfile
touch Vagrantfile
echo "Vagrant.configure("2") do |config|" > Vagrantfile
echo "  config.vm.define \"web\" do |web|" >> Vagrantfile
echo "    web.vm.box = \"ubuntu/xenial64\"" >> Vagrantfile
echo "    web.vm.network \"private_network\", ip: \"192.168.33.11\"" >> Vagrantfile
echo "    web.vm.synced_folder \"./data\", \"/var/www/html\"" >> Vagrantfile
# echo "    web.vm.provision \"shell\", path: \"https://raw.githubusercontent.com/It-DreamTeam/Vox-Populi/master/Script/serverInstall.sh\", :args => \"'web'\"" >> Vagrantfile
echo "    web.vm.provision \"shell\", path: \"./serverInstall.sh\", :args => \"'web'\"" >> Vagrantfile
echo "  end" >> Vagrantfile
echo "  config.vm.define \"db\" do |db|" >> Vagrantfile
echo "    db.vm.box = \"ubuntu/xenial64\"" >> Vagrantfile
echo "    db.vm.network \"private_network\", ip: \"192.168.33.12\"" >> Vagrantfile
echo "    db.vm.synced_folder \"./data2\", \"/home/ubuntu\"" >> Vagrantfile
# echo "    db.vm.provision \"shell\", path: \"https://raw.githubusercontent.com/It-DreamTeam/Vox-Populi/master/Script/serverInstall.sh\", :args => \"'db' '${SqlPassword}'\"" >> Vagrantfile
echo "    db.vm.provision \"shell\", path: \"./serverInstall.sh\", :args => \"'db'\"" >> Vagrantfile
echo "  end" >> Vagrantfile
# echo "  config.vm.define \"nagios\" do |nagios|" >> Vagrantfile
# echo "    nagios.vm.box = \"ubuntu/xenial64\"" >> Vagrantfile
# echo "    nagios.vm.network \"private_network\", ip: \"192.168.33.13\"" >> Vagrantfile
# # echo "    nagios.vm.provision \"shell\", path: \"https://raw.githubusercontent.com/It-DreamTeam/Vox-Populi/master/Script/serverInstall.sh\", :args => \"'nagios' '${SqlPassword}'\"" >> Vagrantfile
# echo "    nagios.vm.provision \"shell\", path: \"./serverInstall.sh\", :args => \"'nagios'\"" >> Vagrantfile
# echo "  end" >> Vagrantfile
echo "end" >> Vagrantfile

# Lancement de deux vagrant (Web and DB)
vagrant up
