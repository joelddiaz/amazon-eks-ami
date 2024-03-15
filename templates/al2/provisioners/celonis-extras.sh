#!/usr/bin/env bash

set -o pipefail
set -o nounset
set -o errexit
IFS=$'\n\t'

################################################################################
### Clean Iptables rules due STIG image ###############################################################
################################################################################
cat << EOF | sudo tee /etc/sysconfig/iptables
*filter
:INPUT ACCEPT [0:0
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
COMMIT
EOF

################################################################################
### Grow var volumes ###############################################################
################################################################################
sudo pvresize /dev/sdf
sudo lvextend -l +95%FREE /dev/vg-01/var_vol
sudo lvextend -l +100%FREE /dev/vg-01/var-log-audit_vol
