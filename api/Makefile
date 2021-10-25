SHELL:=/bin/bash

UNAME=$(shell uname)

PROTOC=protoc
PROTO_SRCS=$(wildcard ./protos/*.proto)
PROTO_SWIFT_TAG=1.18.0
PROTO_DOCS_VERSION=latest
PROTO_DOCS_FORMAT=markdown,README.md

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
	$(PROTOC) \
	--python_out=./python/ \
	-I ./protos/ \
	$^

.PHONY: proto-swift
proto-swift: $(PROTO_SRCS)
	$(PROTOC) \
	--swift_out=./swift/ \
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
	pip3 install grpcio

.PHONY: dep-Darwin
dep-Darwin:
	brew install protobuf
	brew install swift-protobuf

.PHONY: dep-Linux
dep-Linux:
	sudo apt update
	sudo apt install -y protobuf-compiler
	git clone https://github.com/apple/swift-protobuf.git
	cd swift-protobuf
	git checkout tags/$(PROTO_SWIFT_TAG)
	swift build -c release
	sudo cp .build/release/protoc-gen-swift /usr/bin/

.PHONY: clean
clean:
	rm $(RM_OPTS) go/*
	rm $(RM_OPTS) python/*
	rm $(RM_OPTS) swift/*

.PHONY: all
all: dep proto

.DEFAULT_GOAL=all
