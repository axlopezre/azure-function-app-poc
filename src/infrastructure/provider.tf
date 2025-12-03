terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}

  # Forzamos la suscripción explícitamente
  subscription_id = "1a16499f-2e77-4807-a9bd-1e80af3d210f"
}
