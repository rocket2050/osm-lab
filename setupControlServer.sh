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

  rm -rf /etc/ansible/roles/osm_jenkins
  git clone https://github.com/opstree-ansible/osm_jenkins /etc/ansible/roles/osm_jenkins

  rm -rf /etc/ansible/roles/osm_java
  git clone https://github.com/opstree-ansible/osm_java.git /etc/ansible/roles/osm_java

  rm -rf /etc/ansible/roles/osm_nginx
  git clone https://github.com/opstree-ansible/osm_nginx.git /etc/ansible/roles/osm_nginx

  rm -rf /etc/ansible/roles/osm_mongodb
  git clone https://github.com/opstree-ansible/osm_mongodb.git -b release-1.0 /etc/ansible/roles/osm_mongodb

  rm -rf /etc/ansible/roles/osm_gitlab
  git clone https://github.com/opstree-ansible/osm_gitlab.git /etc/ansible/roles/osm_gitlab

  rm -rf /etc/ansible/roles/osm_snoopy
  git clone https://github.com/opstree-ansible/osm_snoopy.git /etc/ansible/roles/osm_snoopy

  rm -rf /etc/ansible/roles/osm_elasticsearch
  git clone https://github.com/opstree-ansible/osm_elasticSearch.git /etc/ansible/roles/osm_elasticsearch

  rm -rf /etc/ansible/roles/osm_kibana
  git clone https://github.com/opstree-ansible/osm_kibana.git /etc/ansible/roles/osm_kibana
}


function setupJenkins() {
  ansible-playbook -i /opt/osm/inventory /opt/osm/playbooks/jenkins.yaml
}

installSoftwares
installAnsibleRoles
setupJenkins
