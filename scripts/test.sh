#!/bin/sh
set -e
cd /usr/sbin/
ln -s /usr/bin/chromedriver chromedriver
go run /app/proto/main.go
