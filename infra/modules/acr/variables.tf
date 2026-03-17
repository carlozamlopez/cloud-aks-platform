variable "prefijo" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "aks_principal_id" {
  description = "Principal ID del AKS para pull de imagenes"
  type        = string
  default     = ""
}