locals {
  base_app_settings = {
    FUNCTIONS_WORKER_RUNTIME = var.runtime_stack
    WEBSITE_RUN_FROM_PACKAGE = "1"
    AzureWebJobsStorage      = azurerm_storage_account.functions.primary_connection_string
  }
}

locals {
  durable_app_settings = var.enable_durable ? {
    AzureWebJobsStorage = azurerm_storage_account.functions.primary_connection_string
  } : {}
}

locals {
  cosmos_app_settings = var.cosmos_connection_string != null ? {
    CosmosDBConnection = var.cosmos_connection_string
  } : {}
}
