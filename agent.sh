#!/bin/bash
# @author: Yury Dubinin
# @project: ADO agent pool infra
# Please don't include any credentials or secrets in this script

ADO_ORG=$1
ADO_TOKEN=$1

set -x

exec &>> /var/log/postinstall.log
echo "Script started at $(date +%F_%H-%M-%S)"
echo "Install compat-openssl10 libaio"
sudo dnf install -y compat-openssl10 libaio
echo "Install git"
sudo yum install -y git 
git -v
echo "Install yum-utils"
sudo yum install -y yum-utils
echo "Install terraform"
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform
terraform -v
echo "Download Azure DevOps Agent"
wget -q https://vstsagentpackage.azureedge.net/agent/2.214.2/vsts-agent-rhel.6-x64-2.214.2.tar.gz
tar zxvf ~/vsts-agent-rhel.6-x64-2.214.2.tar.gz
ls -all
echo "Install dependencies for Azure DevOps Agent"
sudo ~/bin/installdependencies.sh
echo "Install Config for Azure DevOps Agent"
~/config.sh --unattended --acceptTeeEula --agent 'ADO-AGENT-RHEL8' --pool 'AZR-NN-XAAS-POC' --replace --url "https://dev.azure.com/$ADO_ORG" --auth 'PAT' --token "$ADO_TOKEN"

sudo ~/svc.sh install azureuser
sudo ~/svc.sh start
sudo ~/svc.sh status
echo "Script ended at $(date +%F_%H-%M-%S)"
