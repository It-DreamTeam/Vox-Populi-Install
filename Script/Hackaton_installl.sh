#!/bin/bash
#################### Script Memo ####################
#     Création et Configuration du Vagrant File     #
#     Installation apache2, Php7, Activation Ext    #
#     Configuration Envars, Vhost                   #
#     Download Composer, Installation CakePhp       #
#     Paramétrage CakePhp                           #
#####################################################

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
else
  test=0
  while [ ${test} -eq 0 ]; do
    read -s -p "Enter Password for root MySQL: `echo $'\n> '`" SqlPassword
    echo `echo $'\n '`
    read -s -p "Confirm Password for root MySQL: `echo $'\n> '`" SqlConfirmPass
    echo `echo $'\n '`
    if [ ${SqlPassword} = ${SqlConfirmPass} ]; then
      test=1
    fi
  done

  ### Création du Fichier Vagrantfile
  touch Vagrantfile
  echo "Vagrant.configure("2") do |config|" > Vagrantfile
  echo "  config.vm.define \"web\" do |web|" >> Vagrantfile
  echo "    web.vm.box = \"ubuntu/xenial64\"" >> Vagrantfile
  echo "    web.vm.network \"private_network\", ip: \"192.168.33.11\"" >> Vagrantfile
  echo "    web.vm.synced_folder \"./data\", \"/var/www/html\"" >> Vagrantfile
  echo "    web.vm.provision \"shell\", path: \"https://raw.githubusercontent.com/It-DreamTeam/Vox-Populi/master/Script/serverInstall.sh\", :args => \"'web'\"" >> Vagrantfile
  # echo "    web.vm.provision \"shell\", path: \"../GitHubVersion/Vox-Populi-Install/Script/serevrInstall.sh\", :args => \"'web'\"" >> Vagrantfile
  echo "  end" >> Vagrantfile
  echo "  config.vm.define \"db\" do |db|" >> Vagrantfile
  echo "    db.vm.box = \"ubuntu/xenial64\"" >> Vagrantfile
  echo "    db.vm.network \"private_network\", ip: \"192.168.33.12\"" >> Vagrantfile
  echo "    db.vm.provision \"shell\", path: \"https://raw.githubusercontent.com/It-DreamTeam/Vox-Populi/master/Script/serverInstall.sh\", :args => \"'db' '${SqlPassword}'\"" >> Vagrantfile
  echo "  end" >> Vagrantfile
  # echo "  config.vm.define \"nagios\" do |nagios|" >> Vagrantfile
  # echo "    db.vm.box = \"ubuntu/xenial64\"" >> Vagrantfile
  # echo "    db.vm.network \"private_network\", ip: \"192.168.33.13\"" >> Vagrantfile
  # echo "    db.vm.provision \"shell\", path: \"https://raw.githubusercontent.com/It-DreamTeam/Vox-Populi/master/Script/serverInstall.sh\", :args => \"'nagios' '${SqlPassword}'\"" >> Vagrantfile
  # echo "  end" >> Vagrantfile
  echo "end" >> Vagrantfile

  # Lancement de deux vagrant (Web and DB)
  vagrant up

  play end2.mp3

fi
