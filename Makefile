build-cserver:
	docker build -t opstree/osm:cserver -f Dockerfile.cserver .

build-tserver:
	docker build -t opstree/osm:tserver -f Dockerfile.tserver .

build-all:
	make build-cserver
	make build-tserver
