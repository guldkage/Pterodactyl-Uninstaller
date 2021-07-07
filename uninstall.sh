#!/bin/bash

########################################################################
#                                                                      #
# Pterodactyl Uninstaller Script #                                         #
                                                                       #
# This script is not associated with the official Pterodactyl Panel.   #
#                                                                      #
########################################################################

if [[ $EUID -ne 0 ]]; then
  echo "* This script must be executed with root"
  exit 1
fi

warning(){
    echo -e '\e[31m'$1'\e[0m';
}

panel(){
  if [[ "$panel" =~ [Yy] ]]; then
    sudo rm -rf /var/www/pterodactyl # Removes panel files
    sudo rm /etc/systemd/system/pteroq.service # Removes pteroq service worker
    sudo unlink /etc/nginx/sites-enabled/pterodactyl.conf # Removes nginx config (if using nginx)
    sudo unlink /etc/apache2/sites-enabled/pterodactyl.conf # Removes Apache config (if using apache)
    sudo rm -rf /var/www/pterodactyl # Removing panel files
    sleep 2s
    warning "[!] Your panel has been removed. You are now left with your database and web server."
    warning "[!] If you want to delete your database, simply go into MySQL and type DROP DATABASE (database name);"
    warning "[!] Thank you for using this script!"
    sleep 1s
    echo ""
    warning "[!] Should Wings be removed?"
    echo "(y/n)"
    readwings
  else
    warning "[!] Uninstallation aborted!"
    fi
    exit 2
}

readwings(){
    read -r wings
    wings
}

wings(){
  if [[ "$wings" =~ [Yy] ]]; then
    sudo systemctl stop wings # Stops wings
    sudo rm -rf /var/lib/pterodactyl # Removes game servers and backup files
    sudo rm -rf /etc/pterodactyl # Removes wings config
    sudo rm /usr/local/bin/wings # Removes wings
    sudo rm /etc/systemd/system/wings.service # Removes wings service file
    warning "[!] Successfully removed wings!"
  else
    exit 3
  fi
}

echo "[!] Welcome to Pterodactyl Uninstaller Script!"
warning "[!] This script is not associated with the Pterodactyl Panel."
sleep 0.5s
echo ""
warning "[!] Warning: This command will uninstall the Pterodactyl Panel! By continuing the script will uninstall your panel."
warning "[!] Disclaimer: This script is not responsable for any damage!"
echo "Do you want to continue?"
echo "(y/n)"
read -r panel
panel
