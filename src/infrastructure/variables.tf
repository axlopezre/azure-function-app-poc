variable "environment" {
  description = "Nombre del entorno: dev, QA o prod."
  type        = string
}

variable "project_name" {
  type        = string
  default     = "my-azfunc-poc"
  description = "Prefijo para nombrar los recursos."
}

variable "location" {
  type        = string
  default     = "eastus"
  description = "Región de Azure."
}

variable "runtime_stack" {
  type        = string
  default     = "python"
  description = "Stack de runtime (python / node / dotnet)."
}

variable "python_version" {
  type        = string
  default     = "3.11"
  description = "Versión de Python para la Function."
}

variable "function_service_plan_name" {
  type        = string
  default     = "plan-func-python-mch01"
  description = "Nombre para Application Insights (o similar)."
}