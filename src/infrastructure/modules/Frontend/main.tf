resource "azurerm_service_plan" "plan" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name = "S1"
  os_type  = "Linux"
}

resource "azurerm_linux_web_app" "frontend" {
  name                = var.web_app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.plan.id

  https_only = true

  site_config {
    application_stack {
      node_version = "20-lts"
    }
  }

  app_settings = {
    WEBSITES_PORT                  = "3000"
    SCM_DO_BUILD_DURING_DEPLOYMENT = "true"
    NEXT_TELEMETRY_DISABLED        = "1"
  }
}