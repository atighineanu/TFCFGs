#!/bin/sh
cp -r other-files/* /usr/share/caasp/terraform/vmware/
cp -r other-files/imba-cluster /root/go/src/mkcaasp/tests/ginkgoscenarios/scenario1/
mkdir -p .kube/config
cp /root/go/src/mkcaasp/tests/ginkgoscenarios/scenario1/imba-cluster/admin.conf .kube/config
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
zypper -ar $1
zypper up --auto-agree-with-licenses --no-confirm skuba
zypper up --auto-agree-with-licenses --no-confirm cri-o
sleep 10;
rpm -qi cri-o | egrep -i "version|release"
cp -r /usr/share/caasp/terraform/vmware/* some-files/
cp -r /root/go/src/mkcaasp/tests/ginkgoscenarios/scenario1/imba-cluster some-files/
