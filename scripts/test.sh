#!/bin/sh
cd /usr/sbin/
ln -s /usr/bin/chromedriver chromedriver
go run /app/proto/main.go
