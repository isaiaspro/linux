#!/bin/bash

# Configurar o locale para pt_BR.UTF-8
sudo locale-gen pt_BR.UTF-8
sudo localectl set-locale LANG=pt_BR.UTF-8
sudo update-locale LANG=pt_BR.UTF-8 LC_ALL=pt_BR.UTF-8 LANGUAGE="pt_BR:pt:en"

# Configurar o fuso horário para America/Sao_Paulo
sudo timedatectl set-timezone "America/Sao_Paulo"

# Instalar o pacote ntp
sudo apt-get install ntp

# Parar o serviço ntp
sudo service ntp stop

# Criar o arquivo /etc/ntp.drift
sudo touch /etc/ntp.drift

# Escrever as configurações no arquivo /etc/ntp.conf
echo 'leapfile /usr/share/zoneinfo/leap-seconds.list
driftfile /var/lib/ntpsec/ntp.drift
server a.st1.ntp.br iburst nts
server b.st1.ntp.br iburst nts
server c.st1.ntp.br iburst nts
server d.st1.ntp.br iburst nts
server gps.ntp.br iburst nts
restrict default kod nomodify nopeer noquery limited
restrict 127.0.0.1
restrict ::1' | sudo tee /etc/ntp.conf

# Iniciar e reiniciar o serviço ntp
sudo service ntp start
sudo service ntp restart
sudo systemctl restart ntp

# Conferir o status do serviço ntp
sudo systemctl status ntp

# Conferir a hora atual do sistema
date
