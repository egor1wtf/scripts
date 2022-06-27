#!/bin/bash

#Скрипт предназначен для инсталляции Wine 7.3 в ОС ALSE 1.7.0 и ALSE 1.7.1. Перед запуском скрипта необходимо убедиться, что компьютер подключен к сети интернет.

#При появлении окна "Установка Wine Mono" со следующим содержимым "Wine не может найти пакет wine-mono..." необходимо нажать кнопку "Отмена"

#Запуск скрипта осуществляется от текущего пользователя командой: "source install_wine_7.3_1.7.sh"

#Запуск wine осуществляется командой: "wine <файл>.exe". Проверить корректность работоспособности wine возможно с помощью команды: "wine notepad" 


#The script is designed to install Wine 7.3 in OS ALSE 1.7.0 and ALSE 1.7.1. Before running the script, you need to make sure that the computer is connected to the Internet.

#When the "Install Wine Mono" window appears with the following content "Wine cannot find the wine-mono package...", you must click the "Cancel" button

#The script is run from the current user with the command: "source install_wine_7.3_1.7.sh"

#Wine is started with the command: "wine <file>.exe". You can check if wine is working correctly using the command: "wine notepad"

sudo apt install libc6-i386 ca-certificates wget -y

IA32_VER=`apt search ia32-libs 2>/dev/null | grep 'ia32-lib' | grep -v dev | awk '{ print $2 }'`

if [[ $IA32_VER == 20211017+1.7se ]]; then
    
    wget -P  /tmp/ https://artifactory.astralinux.ru/artifactory/sup-service-generic/ia32-libs_20220330%2B1.7se_amd64.deb
    sudo apt install /tmp/ia32-libs_20220330+1.7se_amd64.deb -y
    
else
    sudo apt install ia32-libs -y
fi

wget -P  /tmp/ https://artifactory.astralinux.ru/artifactory/sup-service-generic/wine_7.3-0-astra-se17_amd64.deb
sudo apt install /tmp/wine_7.3-0-astra-se17_amd64.deb -y

CABEX_VER=`apt search cabextract 2>/dev/null | grep 'cabextract' | grep -v dev | awk '{ print $2 }'`
LIBMS_VER=`apt search libmspack0 2>/dev/null | grep 'libmspack0' | grep -v dev | awk '{ print $2 }'`

if [[ -z "$CABEX_VER" ]] || [[ -z "$LIBMS_VER" ]]; then
    
         wget -P /tmp/ https://download.astralinux.ru/astra/stable/1.7_x86-64/repository-extended/pool/main/c/cabextract/cabextract_1.9-1_amd64.deb
         wget -P /tmp/ https://download.astralinux.ru/astra/stable/1.7_x86-64/repository-extended/pool/main/libm/libmspack/libmspack0_0.10.1-2_amd64.deb

    sudo apt install /tmp/cabextract_1.9-1_amd64.deb /tmp/libmspack0_0.10.1-2_amd64.deb -y
else
    sudo apt install cabextract libmspack0 -y
fi

wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
sudo chmod +x winetricks
sudo mv -f winetricks /usr/bin

export WINE=/opt/wine-7.3/bin/wine
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/opt/wine-7.3/bin/
echo "export WINE=/opt/wine-7.3/bin/wine" >> $HOME/.bashrc
echo "export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/opt/wine-7.3/bin/" >> $HOME/.bashrc
