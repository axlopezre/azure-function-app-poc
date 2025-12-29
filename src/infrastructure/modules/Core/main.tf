locals {
  default_tags = {
    environment = var.environment
  }

  merged_tags = merge(local.default_tags, var.tags)
}

resource "azurerm_servicebus_namespace" "this" {
  name                = var.servicebus_namespace_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku = "Standard"

  # Requerimientos solicitados
  minimum_tls_version          = "1.2"
  local_auth_enabled           = true
  public_network_access_enabled = true

  tags = local.merged_tags
}