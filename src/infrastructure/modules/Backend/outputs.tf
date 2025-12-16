output "function_app_name" {
  value = azurerm_linux_function_app.functions.name
}

output "service_plan_id" {
  value = azurerm_service_plan.plan.id
}