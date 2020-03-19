#!/bin/sh
export MKCAASPROOT=/root/go/src/mkcaasp
export GO111MODULE=on
cp other-files/mkcaaspcfg.json /root/go/src/mkcaasp/
cp -r other-files/* /usr/share/caasp/terraform/vmware/
cp -r other-files/imba-cluster /root/go/src/mkcaasp/tests/ginkgoscenarios/deploy01/
cd /root/go/src/github.com/fgerling/bdd-poc
git pull
rm -r /root/go/src/github.com/fgerling/bdd-poc/imba-cluster
cp -r other-files/imba-cluster /root/go/src/github.com/fgerling/bdd-poc/
export KUBECONFIG=/root/go/src/github.com/fgerling/bdd-poc/imba-cluster/admin.conf
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
godog features/skuba_upgrade/skuba_upgrade-01.feature
cp -r /usr/share/caasp/terraform/vmware/* some-files/
cp -r /root/go/src/mkcaasp/tests/ginkgoscenarios/scenario1/imba-cluster some-files/