terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.41.0"
    }
  }
#   backend "azurerm" {
#     resource_group_name  = "rg-dev-todoapp12356"
#       storage_account_name = "toddostrg"
#       container_name       = "tfstate"
#       key                  = "terraform.tfstate"
   }

provider "azurerm" {
  features {}
  subscription_id = "0f48ce1f-16d2-42ba-8b4f-0bef1a58b563"
}
