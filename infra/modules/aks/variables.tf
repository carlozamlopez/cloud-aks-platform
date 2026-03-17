variable "prefijo"             { type = string }
variable "location"            { type = string }
variable "resource_group_name" { type = string }
variable "nombres"             { type = map(string) }
variable "tags"                { type = map(string) }
variable "subnet_id" {
  description = "Subnet ID donde van los nodos de AKS"
  type        = string
}
variable "log_analytics_id" {
  description = "Log Analytics Workspace ID para monitoreo"
  type        = string
}
variable "node_count" {
  description = "Numero de nodos en el pool"
  type        = number
  default     = 1  # 1 para lab, 2+ para producción
}
variable "vm_size" {
  description = "Tamaño de VM para los nodos"
  type        = string
  default     = "Standard_DC2s_v3"  # económico para lab
}