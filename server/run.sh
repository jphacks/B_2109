#!/usr/bin/env bash

go build -o ./bookowl
./bookowl --addr 0.0.0.0:8080 --db-addr localhost:3306 --db-name bookowl --db-user root --db-pass password --http-addr 0.0.0.0:8081
