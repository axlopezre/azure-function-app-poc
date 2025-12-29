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

resource "azurerm_servicebus_queue" "invoice_processing_qa" {
  name         = var.servicebus_queue_name
  namespace_id = azurerm_servicebus_namespace.this.id

  # Capacidad
  max_size_in_megabytes = 81920 # 80 GB

  # Mensajes
  max_delivery_count = 10
  default_message_ttl = "P1D" # 1 día
  lock_duration       = "PT1M" # 1 minuto

  # Características
  requires_session    = true

  # Dead-letter
  dead_lettering_on_message_expiration = true

  # Duplicados
  requires_duplicate_detection = true
  duplicate_detection_history_time_window = "PT10M"

  # Auto delete
  auto_delete_on_idle = "P10675199DT2H48M5.4775807S" # NEVER

  status = "Active"
}