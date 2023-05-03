## include .env
ifneq (,$(wildcard ./.env))
	include .env
	export
endif

DOCKER_EXEC = docker run \
				-u $(shell id -u):$(shell id -g) \
				--rm \
				-v $(PWD):/opt \
				$(DOCKER_HUB_REPO):latest

## App commands
run:
	@$(DOCKER_EXEC) python3 /opt/app/helloworld.py
.PHONEY: run

debug:
	@docker run \
				-u $(shell id -u):$(shell id -g) \
				-it \
				--rm \
				-v $(PWD):/opt \
				$(DOCKER_HUB_REPO):latest /bin/bash
.PHONEY: debug

## Build Agent Commands
# build
build:
	@echo "$(ANSIBLE_VAULT_PASS)" > docker/ansible_vault_password
	@cd docker && docker build \
					--build-arg UID=$(shell id -u) \
					--build-arg GID=$(shell id -g) \
					--build-arg USERNAME=$(shell id -un) \
					--build-arg GROUPNAME=$(shell id -gn) \
					-t $(DOCKER_HUB_REPO):latest .
	@rm docker/ansible_vault_password
.PHONEY: build

# rebuild
rebuild: clean build push
.PHONEY: rebuild

# clean
clean:
	@cd docker && docker rmi $(DOCKER_HUB_REPO):latest &>/dev/null || true
.PHONEY: clean

# push
push:
	@docker login && docker push $(DOCKER_HUB_REPO):latest
.PHONEY: push

# pull
pull:
	@docker pull $(DOCKER_HUB_REPO):latest
.PHONEY: pull





