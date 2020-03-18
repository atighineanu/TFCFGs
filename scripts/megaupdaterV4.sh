#!/bin/sh
export MKCAASPROOT=/root/go/src/mkcaasp
export GO111MODULE=on
cp other-files/mkcaaspcfg.json /root/go/src/mkcaasp/
cp -r other-files/* /usr/share/caasp/terraform/vmware/
cp -r other-files/imba-cluster /root/go/src/mkcaasp/tests/ginkgoscenarios/deploy01/
export KUBECONFIG=/root/go/src/mkcaasp/tests/ginkgoscenarios/deploy01/imba-cluster/admin.conf
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
/root/go/src/mkcaasp/main -v 4 -rpm -createcaasp -action init
echo REPO: "${1}"
echo PACKAGE: "${2}"
/root/go/src/mkcaasp/main -v 4 -rpm -cmd "sudo zypper ar ${1}" -all
zypper up --auto-agree-with-licenses --no-confirm skuba
zypper up --auto-agree-with-licenses --no-confirm
sleep 10;
/root/go/src/mkcaasp/main -v 4 -rpm -cmd "sudo zypper lr -puU" -all
/root/go/src/mkcaasp/main -v 4 -rpm -cmd "sudo zypper -n up" -all
sleep 3;
/root/go/src/mkcaasp/main -v 4 -rpm -cmd "rpm -qi ${2}" -all
/root/go/src/mkcaasp/main -v 4 -rpm -ginkgo check_container_versions02
cp -r /usr/share/caasp/terraform/vmware/* some-files/
cp -r /root/go/src/mkcaasp/tests/ginkgoscenarios/scenario1/imba-cluster some-files/
