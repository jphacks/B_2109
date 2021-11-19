SHELL:=/bin/bash

GO=go
GO_BUILD_OPT=-v
GO_VET_OPTS=-v
GO_TEST_OPTS=-v -race

GINKGO=ginkgo
GINKGO_TEST_OPTS=-race

RM_OPTS=-f

CMD_DIRS:=$(wildcard cmd/*)
CMDS:=bin/bookowl

DOCKER:=docker
DOCKER_FILE:=./docker/bookowl.Dockerfile
DOCKER_REPO:=ghcr.io/chez-shanpu/bookowl
DOCKER_TAG:=latest
DOCKER_CONTEXT:=./

DOCKERCOMPOSE=docker-compose
DOCKERCOMPOSE_TEST_FILE=docker-compose.test.yaml
DOCKERCOMPOSE_DEV_FILE=docker-compose.dev.yaml

.SECONDEXPANSION:
bin/%:
	$(GO) build $(GO_BUILD_OPT) -o ./$@


.PHONY: docker
docker:
	$(DOCKER) image build -f ./docker/bookowl.Dockerfile -t $(DOCKER_REPO):$(DOCKER_TAG) $(DOCKER_CONTEXT)

.PHONY: build
build: $(CMDS)

.PHONY: vet
vet:
	$(GO) vet $(GO_VET_OPTS) ./...

.PHONY: test
test: vet run
#	$(GO) test $(GO_TEST_OPTS) ./...
	$(GINKGO) $(GINKGO_TEST_OPTS) ./...

.PHONY: mod
mod:
	$(GO) mod tidy

.PHONY: clean
clean:
	-$(GO) clean
	-rm $(RM_OPTS) bin/*

.PHONY: test-run
test-run:
	$(DOCKERCOMPOSE) -f $(DOCKERCOMPOSE_TEST_FILE) down --volumes
	$(DOCKERCOMPOSE) -f $(DOCKERCOMPOSE_TEST_FILE) up -d

.PHONY: run
run:
	$(DOCKERCOMPOSE) -f $(DOCKERCOMPOSE_DEV_FILE) down --volumes
	$(DOCKERCOMPOSE) -f $(DOCKERCOMPOSE_DEV_FILE) up -d

.PHONY: all
all: mod vet build docker

.DEFAULT_GOAL=all