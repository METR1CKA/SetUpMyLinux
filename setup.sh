#!/bin/bash

# Colores
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

trap ctrl_c INT

function ctrl_c(){
  echo -e "\n${redColour}[!] Cancelando procesos...${endColour}"
  exit
}

# Actualización de repositorios

function update_upgrade(){
  sleep 1
  echo -e "\n${greenColour}[+] Actualizando repositorios...${endColour}\n"
  sleep 1
  sudo apt update && sudo apt upgrade -y
  sleep 1
}

# Instalación de dependencias de ubuntu

function dependencias_ubuntu(){
  echo -e "\n${greenColour}[+] Instalando ubuntu-restricted-extras..${endColour}\n"
  sleep 1
  sudo apt install ubuntu-restricted-extras
  sleep 1
}

# Instalación de dependencias de flatpak

function dependencias_flatpak(){
  echo -e "\n${greenColour}[+] Instalando flatpak...${endColour}\n"
  sleep 1
  sudo apt install flatpak
  sleep 1
  echo -e "\n${greenColour}[+] Instalando gnome-software-plugin-flatpak...${endColour}\n"
  sudo apt install gnome-software-plugin-flatpak
  sleep 1
  echo -e "\n${greenColour}[+] Configurando flatpak...${endColour}\n"
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  echo -e "\n${greenColour}[+] Flatpak configurado...${endColour}\n"
  sleep 1
}

# Instalación de utilerias y configuraciones

function configs_utils(){
  echo -e "\n${greenColour}[+] Instalando utilerias...${endColour}\n"
  sleep 1
  sudo apt install vlc rar unace p7zip p7zip-full p7zip-rar unrar lzip lhasa arj sharutils mpack lzma lzop cabextract gparted preload prelink
  sleep 1
  echo -e "\n${greenColour}[+] Añadiendo configuraciones${endColour}\n"
  sleep 1
  echo 'vm.swappiness=40' >> /etc/sysctl.conf
}

# Funcion principal

function main(){
  clear
  sleep 1
  echo -e "\n${yellowColour}[*] Iniciando procesos${endColour}\n"
  update_upgrade
  dependencias_ubuntu
  dependencias_flatpak
  configs_utils
  sleep 1
  echo -e "\n${yellowColour}[*] Procesos terminados, por favor reinicie su sistema para efectuar los cambios...${endColour}\n"
}

# Permisos root

if [ "$(id -u)" != "0" ]
then

  echo -e "\n${redColour}[!] No eres usuario root...${endColour}"
  
  exit

fi

main