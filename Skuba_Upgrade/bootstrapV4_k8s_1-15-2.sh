#!/bin/sh
export MKCAASPROOT=/root/go/src/mkcaasp
cp -r some-files/* /root/go/src/github.com/SUSE/skuba/ci/infra/vmware/
cp some-files/mkcaaspcfg.json /root/go/src/mkcaasp/
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
cd /root/go/src/mkcaasp
go run caasp/main.go -v 4 -vmware -createcaasp -action init
sleep 5
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
go run caasp/main.go -v 4 -vmware -createcaasp -action refresh
sleep 10
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
sleep 3
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
export GO111MODULE=on
go run caasp/main.go -v 4 -k8sversion 1.15.2 -ginkgo deploy01
sleep 1
cp /root/go/src/mkcaasp/mkcaaspcfg.json other-files/
cp -r /root/go/src/github.com/SUSE/skuba/ci/infra/vmware/* other-files/
cp -r /root/go/src/mkcaasp/tests/ginkgoscenarios/imba-cluster other-files/