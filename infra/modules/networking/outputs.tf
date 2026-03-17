output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "subnet_ids" {
  description = "Mapa de subnet_name → subnet_id"
  value       = { for k, v in azurerm_subnet.subnets : k => v.id }
}

output "nsg_ids" {
  description = "Mapa de nsg_name → nsg_id"
  value       = { for k, v in azurerm_network_security_group.nsgs : k => v.id }
}

output "log_analytics_id" {
  value = azurerm_log_analytics_workspace.log.id
}

output "log_analytics_workspace_id" {
  description = "Workspace ID — usado por Sentinel y Monitor"
  value       = azurerm_log_analytics_workspace.log.workspace_id
}