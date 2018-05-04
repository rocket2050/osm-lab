#!/bin/bash

function installSoftwares() {
  apt-get -y update
  apt-get -y install git vim software-properties-common
  apt-add-repository -y ppa:ansible/ansible
  apt-get -y update
  apt-get -y install ansible python-pip libmysqlclient-dev python2.7-dev
}

function installAnsibleRoles() {

  for role in osm_zabbix mysql-server osm_jenkins osm_java osm_nginx osm_mongodb osm_gitlab osm_snoopy osm_elasticSearch osm_kibana;
  do
    echo $role
    rm -rf /etc/ansible/roles/$role
    git clone https://github.com/opstree-ansible/${role}.git /etc/ansible/roles/${role}
  done
}

function setupJenkins() {
  ansible-playbook -i /opt/osm/inventory /opt/osm/playbooks/jenkins.yaml
}

installSoftwares
installAnsibleRoles
setupJenkins
