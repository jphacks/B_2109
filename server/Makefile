SHELL:=/bin/bash

GO=go
GO_BUILD_OPT=-v
GO_VET_OPTS=-v
GO_TEST_OPTS=-v -race
RM_OPTS=-f

CMD_DIRS:=$(wildcard cmd/*)
CMDS:=bin/bookowl

DOCKER:=docker
DOCKER_FILE:=./docker/bookowl.Dockerfile
DOCKER_REPO:=ghcr.io/chez-shanpu/bookowl
DOCKER_TAG:=latest
DOCKER_CONTEXT:=./

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
test: vet
	$(GO) test $(GO_TEST_OPTS) ./...

.PHONY: mod
mod:
	$(GO) mod tidy

.PHONY: clean
clean:
	-$(GO) clean
	-rm $(RM_OPTS) bin/*

.PHONY: all
all: mod test build docker

.DEFAULT_GOAL=all