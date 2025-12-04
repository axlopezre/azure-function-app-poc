output "function_app_name" {
  value = azurerm_linux_function_app.functions.name
}

output "frontend_app_name" {
  value = azurerm_linux_web_app.frontend.name
}