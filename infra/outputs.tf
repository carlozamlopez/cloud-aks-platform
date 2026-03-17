output "resource_group_name" {
  value = module.networking.resource_group_name
}
output "vnet_id" {
  value = module.networking.vnet_id
}
output "acr_login_server" {
  value = module.acr.acr_login_server
}
output "aks_name" {
  value = module.aks.aks_name
}
output "log_analytics_id" {
  value = module.networking.log_analytics_id
}