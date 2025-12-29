terraform {
  required_version = ">= 1.6.0"

  backend "azurerm" {
    resource_group_name  = "rg-nextract-tfstate"
    storage_account_name = "sa384848670"
    container_name       = "blob-nextract"
    key                  = "poc.tfstate"
  }
}