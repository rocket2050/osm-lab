build-cserver:
	docker build -t opstree/osm:cserver -f Dockerfile.cserver .

build-tserver:
	docker build -t opstree/osm:tserver -f Dockerfile.tserver .

build-all:
	make build-cserver
	make build-tserver

setup-jenkins-host:
	docker rm -f jenkins || true
	docker run -p 8080:8080 -h jenkins  --name jenkins  -itd opstree/osm:tserver

setup-nginx-host:
	docker rm -f nginx || true
	docker run -h nginx  --name nginx  -itd opstree/osm:tserver

setup-tomcat-host:
	docker rm -f tomcat || true
	docker run -h tomcat  --name tomcat  -itd opstree/osm:tserver

setup-postgres-host:
	docker rm -f postgres || true
	docker run -h postgres  --name postgres  -itd opstree/osm:tserver

setup-mongo-host:
	docker rm -f mongo || true
	docker run -h mongo  --name mongo -itd opstree/osm:tserver

setup-redis-host:
	docker rm -f redis || true
	docker run -h redis  --name redis -itd opstree/osm:tserver

setup-sonar-host:
	docker rm -f sonar || true
	docker run -h sonar  --name sonar -itd opstree/osm:tserver

setup-zabbix-host:
	docker rm -f zabbix || true
	docker run -h zabbix  --name zabbix -itd opstree/osm:tserver

setup-cserver-host:
	docker rm -f cserver || true
	docker run -h cserver --name cserver --link jenkins:jenkins --link nginx:nginx --link tomcat:tomcat --link postgres:postgres --link mongo:mongo --link redis:redis --link sonar:sonar --link zabbix:zabbix -v ${PWD}:/opt/OdMont -itd opstree/osm:cserver /bin/bash

setup-lab-hosts:
	make setup-jenkins-host
	make setup-nginx-host
	make setup-tomcat-host
	make setup-postgres-host
	make setup-mongo-host
	make setup-redis-host
	make setup-sonar-host
	make setup-zabbix-host
	make setup-cserver-host
