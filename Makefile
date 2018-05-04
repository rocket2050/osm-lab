build-cserver:
	docker build -t opstree/osm:cserver -f Dockerfile.cserver .

build-tserver:
	docker build -t opstree/osm:tserver -f Dockerfile.tserver .

build-all:
	make build-cserver
	make build-tserver

setup-elasticsearch-host:
	docker rm -f elasticsearch || true
	docker run -h elasticsearch  --name elasticsearch  -itd opstree/osm:tserver

setup-nginx-host:
	docker rm -f nginx || true
	docker run -h nginx  --name nginx  -itd opstree/osm:tserver

setup-tomcat-host:
	docker rm -f tomcat || true
	docker run -h tomcat  --name tomcat  -itd opstree/osm:tserver

setup-mysql-host:
	docker rm -f mysql || true
	docker run -h mysql  --name mysql  -itd opstree/osm:tserver

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

setup-kibana-host:
	docker rm -f kibana || true
	docker run -h kibana  --name kibana -itd opstree/osm:tserver

setup-cserver-host:
	docker rm -f cserver || true
	docker run -h cserver --name cserver -p 8090:8080 --link kibana:kibana --link elasticsearch:elasticsearch --link nginx:nginx --link tomcat:tomcat --link mongo:mongo --link redis:redis --link sonar:sonar --link zabbix:zabbix -v ${PWD}:/opt/osm -itd opstree/osm:cserver /bin/bash

presetup-control-server:
	docker exec cserver bash -c '/opt/osm/setupControlServer.sh'

setup-lab-hosts:
	make build-all
	make setup-elasticsearch-host
	make setup-kibana-host
	make setup-nginx-host
	make setup-tomcat-host
	make setup-mysql-host
	make setup-mongo-host
	make setup-redis-host
	make setup-sonar-host
	make setup-zabbix-host
	make setup-cserver-host
	make presetup-control-server
