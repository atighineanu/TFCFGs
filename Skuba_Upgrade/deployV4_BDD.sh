#!/bin/sh
export MKCAASPROOT=/root/go/src/mkcaasp
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
go run /root/go/src/mkcaasp/caasp/main.go -v 4 -createcaasp -action init -vmware
go run /root/go/src/mkcaasp/caasp/main.go -v 4 -createcaasp -action apply -nodes w2m3 -vmware


cp /root/go/src/mkcaasp/mkcaaspcfg.json some-files/
cp -r /usr/share/caasp/terraform/vmware/* some-files/
cat /usr/share/caasp/terraform/vmware/terraform.tfstate
echo "---end---"