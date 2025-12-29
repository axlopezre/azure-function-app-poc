output "servicebus_namespace_id" {
  description = "ID of the Service Bus Namespace."
  value       = azurerm_servicebus_namespace.this.id
}

output "servicebus_namespace_name" {
  description = "Name of the Service Bus Namespace."
  value       = azurerm_servicebus_namespace.this.name
}

output "servicebus_namespace_primary_connection_string" {
  description = "Primary connection string (RootManageSharedAccessKey)."
  value       = azurerm_servicebus_namespace.this.default_primary_connection_string
  sensitive   = true
}