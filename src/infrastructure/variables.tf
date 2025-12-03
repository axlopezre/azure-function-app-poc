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

variable "github_repo_path" {
  type        = string
  default     = "./my-azfunc-poc"
  description = "Ruta local al código clonado de la Function."
}

variable "runtime_stack" {
  type        = string
  default     = "python"
  description = "Stack de runtime (python / node / dotnet)."
}

variable "python_version" {
  type        = string
  default     = "3.10"
  description = "Versión de Python para la Function."
}

variable "function_service_plan_name" {
  type    = string
  default = "plan-func-python-mch01"
}

variable "storage_name" {
  type    = string
  default = "stfilesmch01"
}
