#!/bin/sh
cp -r other-files/* /usr/share/caasp/terraform/vmware/
cp -r other-files/imba-cluster /root/go/src/mkcaasp/tests/ginkgoscenarios/scenario1/
mkdir -p .kube/config
cp /root/go/src/mkcaasp/tests/ginkgoscenarios/scenario1/imba-cluster/admin.conf .kube/config
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
/root/go/src/mkcaasp/main -v 4 -rpm -createcaasp -action init
echo "${1}"
echo "${2}"
/root/go/src/mkcaasp/main -v 4 -rpm -cmd "sudo zypper ar ${1}" -masters
/root/go/src/mkcaasp/main -v 4 -rpm -cmd "sudo zypper ar ${1}" -workers
/root/go/src/mkcaasp/main -v 4 -rpm -cmd "sudo zypper ar ${1}" -lb
zypper up --auto-agree-with-licenses --no-confirm skuba
zypper up --auto-agree-with-licenses --no-confirm
sleep 10;
/root/go/src/mkcaasp/main -v 4 -rpm -cmd "sudo zypper lr -puU" -masters
/root/go/src/mkcaasp/main -v 4 -rpm -cmd "sudo zypper lr -puU" -workers
/root/go/src/mkcaasp/main -v 4 -rpm -cmd "sudo zypper -n up" -masters
/root/go/src/mkcaasp/main -v 4 -rpm -cmd "sudo zypper -n up" -workers
#/root/go/src/mkcaasp/main -v 4 -rpm -cmd "sudo zypper up --auto-agree-with-licenses --no-confirm cri-o" -masters
#/root/go/src/mkcaasp/main -v 4 -rpm -cmd "sudo zypper up --auto-agree-with-licenses --no-confirm cri-o" -workers
/root/go/src/mkcaasp/main -v 4 -rpm -reboot masters
sleep 90;
/root/go/src/mkcaasp/main -v 4 -rpm -reboot workers
sleep 90;
/root/go/src/mkcaasp/main -v 4 -rpm -cmd "rpm -qi ${2}" -masters
/root/go/src/mkcaasp/main -v 4 -rpm -cmd "rpm -qi ${2}" -workers
#/root/go/src/mkcaasp/main -v 4 -rpm -cmd "rpm -qi cri-o" -lb
/root/go/src/mkcaasp/main.go -v 4 -rpm -ginkgo check_container_versions02
cp -r /usr/share/caasp/terraform/vmware/* some-files/
cp -r /root/go/src/mkcaasp/tests/ginkgoscenarios/scenario1/imba-cluster some-files/
