#!/bin/bash

function installSoftwares() {
  apt-get -y update
  apt-get -y install git vim software-properties-common
  apt-add-repository -y ppa:ansible/ansible
  apt-get -y update
  apt-get -y install ansible python-pip libmysqlclient-dev python2.7-dev
}

function installAnsibleRoles() {
  rm -rf /etc/ansible/roles/osm_zabbix
  git clone https://github.com/opstree-ansible/osm_zabbix.git -b Release-1.1 /etc/ansible/roles/osm_zabbix
  rm -rf /etc/ansible/roles/mysql-server
  git clone https://github.com/opstree-ansible/mysql-server.git /etc/ansible/roles/mysql-server
}

installSoftwares
installAnsibleRoles
