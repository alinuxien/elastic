#!/usr/bin/env bash

echo "*******************************************"
echo "* [1]: RECONSTRUCTION DE L'INDEX DE MANDB *"
echo "*******************************************"
rm -rf /var/cache/man
mandb -c

echo "*************************************"
echo "* [2]: AJOUT DES DEPOTS NECESSAIRES *"
echo "*************************************"
apt-add-repository --yes --update ppa:ansible/ansible
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-add-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

echo "********************************************************"
echo "* [3]: MISE A JOUR DE LA LISTE DES PAQUETS DISPONIBLES *"
echo "********************************************************"
apt-get update

echo "****************************"
echo "* [4]: INSTALLATION DE VIM *"
echo "****************************"
apt-get install -y vim

echo "********************************"
echo "* [5]: INSTALLATION DE ANSIBLE *"
echo "********************************"
apt-get install -y python3.8 software-properties-common ansible
sed -i '/\[defaults\]/a interpreter_python = auto_legacy_silent' /etc/ansible/ansible.cfg
#sed -i 's/#allow_world_readable_tmpfiles = False/allow_world_readable_tmpfiles = True/g' /etc/ansible/ansible.cfg

echo "*******************************"
echo "* [6]: INSTALLATION DE DOCKER *"
echo "*******************************"
apt-get install -y apt-transport-https ca-certificates curl gnupg-agent docker-ce docker-ce-cli containerd.io
usermod -aG docker vagrant

echo "**********************************"
echo "* [7]: INSTALLATION DE TERRAFORM *"
echo "**********************************"
apt-get install -y terraform
sudo -u vagrant terraform -install-autocomplete

echo "**************************************"
echo "* [8]: INSTALLATION DE AMAZON CLI V2 *"
echo "**************************************"
apt-get install -y unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

echo "*************************************************"
echo "* [9]: INSTALLATION DE TREE ET VIDANGE DU CACHE *"
echo "*************************************************"
apt-get install -y tree
apt-get clean -y

echo "**************************************************"
echo "* [10]: INSTALLATION DE LA SUITE ELASTIC ( ELK ) *"
echo "**************************************************"
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee /etc/apt/sources.list.d/elastic-7.x.list
apt-get update
apt-get install -y elasticsearch kibana filebeat metricbeat
sed -i 's/-Xms512m/-Xms4g/g' /etc/elasticsearch/jvm.options
sed -i 's/-Xmx512m/-Xmx4g/g' /etc/elasticsearch/jvm.options
sed -i 's/#server.host: "localhost"/server.host: "0.0.0.0"/g' /etc/kibana/kibana.yml
mkdir /etc/systemd/system/elasticsearch.service.d
echo -e "[Service]\nTimeoutStartSec=180" | tee /etc/systemd/system/elasticsearch.service.d/startup-timeout.conf
/bin/systemctl daemon-reload
/bin/systemctl enable elasticsearch.service
/bin/systemctl start elasticsearch.service
/bin/systemctl enable kibana.service
/bin/systemctl start kibana.service
/bin/systemctl enable filebeat.service
filebeat modules enable elasticsearch
sed -i 's/#username: "elastic"/username: "vagrant"/g' /etc/filebeat/filebeat.yml
sed -i 's/#password: "changeme"/password: "vagrant"/g' /etc/filebeat/filebeat.yml
filebeat setup
/bin/systemctl start filebeat.service
/bin/systemctl enable metricbeat.service
sed -i 's/#username: "elastic"/username: "vagrant"/g' /etc/metricbeat/metricbeat.yml
sed -i 's/#password: "changeme"/password: "vagrant"/g' /etc/metricbeat/metricbeat.yml
/metricbeat setup
/bin/systemctl start metricbeat.service

