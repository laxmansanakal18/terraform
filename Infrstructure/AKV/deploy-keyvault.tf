#### keyvault Creation ####
###########################

# ResourceGroup
resource "resource_group_name" "rg" {
  name         = "#{resourcegroupname}#"
  location     = "#{location}#"
}

data "azurerm_client_config" "current" {}

## Create Azure Key Vault
resource "azurerm_key_vault" "keyvault" {
  name                        = "#{keyVaultName}#"
  resource_group_name         = "#{resourcegroupname}#"
  location                    = "#{location}#"
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "#{kvsku}#"

  tags = {
    environment = "#{env}#"
  }
  lifecycle {
    prevent_destroy = true
  }
}