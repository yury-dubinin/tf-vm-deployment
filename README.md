# tf-vm-deployment
basic template to deploy Win Server with RDP and WinRM and Linux VM with access over SSH

## Current state after deployment

<img width="1073" alt="Screenshot 2023-04-17 at 11 21 45" src="https://user-images.githubusercontent.com/62520712/232442563-de5deba1-0da7-49c0-a99f-7f226bbe953f.png">


<img width="1004" alt="Screenshot 2023-03-27 at 10 42 05" src="https://user-images.githubusercontent.com/62520712/227889543-631aa925-f1c8-4cc4-a3d0-cb6b2bb4e089.png">

## Why?
- https://learn.microsoft.com/en-us/azure/virtual-network/network-security-group-how-it-works

## check it

- https://github.com/globalbao/terraform-azurerm-ansible-linux-vm
- https://docs.ansible.com/ansible/latest/collections/azure/azcollection/azure_rm_virtualmachine_module.html
- https://github.com/SalsaBr/terransiwiniis/blob/main/main.tf
- https://github.com/NoBSDevOps/BookResources/blob/master/Part-II-Project/Virtual-Machines/Ansible-Configuration/iis.yml
- https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1
- https://github.com/hashicorp/terraform-provider-azurerm/blob/main/examples/virtual-machines/windows/vm-custom-extension/main.tf
- https://github.com/jmassardo/Azure-WinRM-Terraform
- https://github.com/hashicorp/terraform-provider-azurerm/tree/main/examples
