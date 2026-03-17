module "networking" {
  source = "./modules/networking"

  prefijo               = local.prefijo
  location              = var.location
  nombres               = local.nombres
  address_space         = var.vnet_address_space
  subnets               = var.subnets
  tags                  = local.tags_globales
  bastion_subnet_prefix = "10.0.4.0/26"
}

module "acr" {
  source = "./modules/acr"

  prefijo             = local.prefijo
  location            = var.location
  resource_group_name = module.networking.resource_group_name
  tags                = local.tags_globales
  aks_principal_id    = module.aks.aks_principal_id
}

module "aks" {
  source = "./modules/aks"

  prefijo             = local.prefijo
  location            = var.location
  resource_group_name = module.networking.resource_group_name
  nombres             = local.nombres
  subnet_id           = module.networking.subnet_ids["workloads"]
  log_analytics_id    = module.networking.log_analytics_id
  node_count          = var.node_count
  vm_size             = var.vm_size
  tags                = local.tags_globales
}