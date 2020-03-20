#!/bin/sh
export MKCAASPROOT=/root/go/src/mkcaasp
cp -r some-files/* /root/go/src/github.com/SUSE/skuba/ci/infra/vmware/
cp some-files/mkcaaspcfg.json /root/go/src/mkcaasp/
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
/root/go/src/mkcaasp/main -v 4 -vmware -createcaasp -action init
sleep 5
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
/root/go/src/mkcaasp/main -v 4 -vmware -createcaasp -action refresh
sleep 10
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
sleep 3
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
export GO111MODULE=on
export GOPATH=/root/go
/root/go/src/mkcaasp/main -v 4 -k8sversion 1.15.2 -ginkgo deploy01
export KUBECONFIG=/root/go/src/github.com/fgerling/bdd-poc/imba-cluster/admin.conf
cd /root/go/src/github.com/fgerling/bdd-poc
git pull
rm -r /root/go/src/github.com/fgerling/bdd-poc/imba-cluster
cp -r /root/go/src/mkcaasp/tests/ginkgoscenarios/imba-cluster .
godog features/skuba_upgrade/skuba_upgrade-01.feature
sleep 10
godog features/skuba_upgrade/skuba_upgrade-01.feature
sleep 30
/root/go/src/mkcaasp/main -v 4 -createcaasp -action destroy
cp /root/go/src/mkcaasp/mkcaaspcfg.json other-files/
cp -r /root/go/src/github.com/SUSE/skuba/ci/infra/vmware/* other-files/
cp -r /root/go/src/mkcaasp/tests/ginkgoscenarios/imba-cluster other-files/