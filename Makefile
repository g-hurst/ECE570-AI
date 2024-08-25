
CONTAINER_NAME = jupyter
CONTAINER_WORKDIR = /ece57000

.phony: docker-build
docker-build:
	docker build -t $(CONTAINER_NAME) .

.phony: docker-run
docker-run: 
	echo $(pwd)
	docker run -p 8888:8888  \
		--mount type=bind,source="$(shell pwd)/Assignment_01",target="$(CONTAINER_WORKDIR)/Assignment_01" \
		$(CONTAINER_NAME)

.phony: docker-shell
docker-shell: 
	echo "this is not yet implimented..."

.phony: docker-rm-dangling
docker-rm-dangling: 
	docker rmi -f $(shell docker images -f "dangling=true" -q)