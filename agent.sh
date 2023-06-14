#!/bin/bash
# @author: Yury Dubinin
# @project: ADO agent pool infra
# Please don't include any credentials or secrets in this script

ADO_ORG=$1
ADO_TOKEN=$1

set -x

exec &>> /var/log/postinstall.log
echo "Script started at $(date +%F_%H-%M-%S)"
sudo dnf install -y git compat-openssl10 libaio

git -v

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform

terraform -v

wget -q https://vstsagentpackage.azureedge.net/agent/2.214.2/vsts-agent-rhel.6-x64-2.214.2.tar.gz
tar zxvf ~/vsts-agent-rhel.6-x64-2.214.2.tar.gz

ls -all

sudo ./bin/installdependencies.sh
.\config.cmd --unattended --acceptTeeEula --agent 'ADO-AGENT-RHEL8' --pool 'AZR-NN-XAAS-POC' --replace --url "https://dev.azure.com/$ADO_ORG" --auth 'PAT' --token "$ADO_TOKEN"

sudo ./svc.sh install
sudo ./svc.sh start
sudo ./svc.sh status
