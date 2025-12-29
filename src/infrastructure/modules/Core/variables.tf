variable "environment" {
  description = "Environment tag/value (e.g., dev, qa, prod)."
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region where resources will be created."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name where the Service Bus Namespace will be created."
  type        = string
}

variable "servicebus_namespace_name" {
  description = "Service Bus Namespace name (must be globally unique in Azure)."
  type        = string
}

variable "tags" {
  description = "Additional tags to merge with defaults."
  type        = map(string)
  default     = {}
}