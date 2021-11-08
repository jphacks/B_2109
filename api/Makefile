SHELL:=/bin/bash

UNAME=$(shell uname)

PYTHON=python3

PROTOC=protoc
PROTO_SRCS=$(wildcard ./protos/*.proto)
PROTO_DOCS_VERSION=latest
PROTO_DOCS_FORMAT=markdown,README.md
GRPC_SWIFT_VERSION=1.5.0

RM_OPTS=-rf

.PHONY: proto
proto: proto-go proto-python proto-swift proto-docs

.PHONY: proto-go
proto-go: $(PROTO_SRCS)
	$(PROTOC) \
	--go_out=../server/api \
	--go_opt=module=github.com/jphacks/B_2109/server/api \
	--go-grpc_out=../server/api \
	--go-grpc_opt=module=github.com/jphacks/B_2109/server/api \
	-I ./protos/ \
	$^

.PHONY: proto-python
proto-python: $(PROTO_SRCS)
	$(PYTHON) -m grpc_tools.protoc \
	--python_out=./python/ \
	--grpc_python_out=./python/ \
	-I ./protos/ \
	$^

.PHONY: proto-swift
proto-swift: $(PROTO_SRCS)
	$(PROTOC) \
	--swift_out=../iOS/Bookowl/grpc \
	--grpc-swift_out=../iOS/Bookowl/grpc \
	-I ./protos/ \
	$^

.PHONY: proto-docs
proto-docs: $(PROTO_SRCS)
	$(PROTOC) \
	--doc_out=./ \
	--doc_opt=$(PROTO_DOCS_FORMAT) \
	$^

.PHONY: dep
dep: dep-$(UNAME)
	go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.26
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.1
	go install github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc@$(PROTO_DOCS_VERSION)
	pip3 install grpcio grpcio-tools
	wget https://github.com/grpc/grpc-swift/releases/download/$(GRPC_SWIFT_VERSION)/protoc-grpc-swift-plugins-$(GRPC_SWIFT_VERSION).zip
	unzip protoc-grpc-swift-plugins-$(GRPC_SWIFT_VERSION).zip
	sudo cp bin/protoc-gen-swift /usr/local/bin/
	sudo cp bin/protoc-gen-grpc-swift /usr/local/bin/

.PHONY: dep-Darwin
dep-Darwin:
	brew install protobuf

.PHONY: dep-Linux
dep-Linux:
	sudo apt update
	sudo apt install -y protobuf-compiler

.PHONY: clean
clean:
	rm $(RM_OPTS) go/*
	rm $(RM_OPTS) python/*
	rm $(RM_OPTS) swift/*

.PHONY: all
all: dep proto

.DEFAULT_GOAL=all
