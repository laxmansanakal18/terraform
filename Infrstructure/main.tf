terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=3.19.1"
    }
  }
}

provider "azurerm" {    
  skip_provider_registration = "true"
  features {}    
}

terraform {
  backend "azurerm" { 
    resource_group_name   = "#{staterg}#"
    storage_account_name  = "#{statestg}#"
    container_name        = "#{statectr}#"
    key                   = "terraform.tfstate"
  }
}


module "AKV" {
  source = "./AKV"
}
module "ASQL" {
  depends_on  = [module.AKV]
  source      = "./ASQL"
}
module "AWA" {
  source = "./AWA"
}
 