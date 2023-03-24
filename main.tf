locals {
  tags = {
    billingReference = var.billingReference
    cmdbReference = var.cmdbReference
    opEnvironment = var.opEnvironment
  }
  environment = {
    subscriptionId = var.subscriptionId
    location = var.location
  }
}

data "azurerm_subnet" "ubsSubnet" {
  name = var.ubsSubnetName
  virtual_network_name = var.ubsVnetName
  resource_group_name = var.ubsNetResourceGroupName
}

resource "azurerm_resource_group" "rg" {
  name = var.resourceGroupName
  location = local.environment.location
  tags = local.tags
}

resource "azurerm_storage_account" "storageaccount" {
  # Storage account names need to be globally unique (across the whole of Azure) so using part of our subscription Id
  # and a MD5 of the resource group in the name helps avoid clashes.
  name = "dgpstorage${substr(local.environment.subscriptionId, 0, 8)}${substr(md5(var.resourceGroupName), 0, 5)}"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  account_kind = "StorageV2"
  account_tier = "Standard"
  account_replication_type = "LRS"

  enable_https_traffic_only = true
  allow_blob_public_access = true

  network_rules {
    default_action = "Deny"
    bypass = [
      "Logging",
      "Metrics",
      "AzureServices"]
    virtual_network_subnet_ids = [
      data.azurerm_subnet.ubsSubnet.id,
      var.agentSubnetId]
  }

  tags = local.tags
}

resource "azurerm_storage_container" "storageaccount" {
  name = "blob"
  storage_account_name = azurerm_storage_account.storageaccount.name
  container_access_type = "blob"
}

resource "azurerm_storage_container" "backend" {
  name = "backend"
  storage_account_name = azurerm_storage_account.storageaccount.name
  container_access_type = "private"
}

resource "azurerm_storage_share" "storageaccount" {
  name = "dgp-share"
  storage_account_name = azurerm_storage_account.storageaccount.name
  quota = 500
}

resource "azurerm_storage_share_directory" "directory" {
  name = "dgp-dev"
  share_name = azurerm_storage_share.storageaccount.name
  storage_account_name = azurerm_storage_account.storageaccount.name
}
resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
}