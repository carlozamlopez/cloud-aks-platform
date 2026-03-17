# ── AKS Cluster ───────────────────────────────────────
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${var.prefijo}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aks-${var.prefijo}"
  kubernetes_version  = "1.32"

  # Node pool del sistema
  default_node_pool {
    name           = "system"
    node_count     = var.node_count
    vm_size        = var.vm_size
    vnet_subnet_id = var.subnet_id
    os_disk_size_gb = 30
    tags = var.tags
  }

  # IDENTITY — Managed Identity
  # Más seguro que Service Principal — no hay credenciales que rotar
  identity {
    type = "SystemAssigned"
  }

  # SECURITY — Entra ID + RBAC
  azure_active_directory_role_based_access_control {
    managed            = true
    azure_rbac_enabled = true
  }

  # NETWORKING — Azure CNI
  # Cada pod recibe IP real de la VNet — visible desde on-premise
  network_profile {
  network_plugin    = "azure"
  load_balancer_sku = "standard"
  service_cidr      = "10.1.0.0/16"   # ← rango separado para servicios AKS
  dns_service_ip    = "10.1.0.10"     # ← debe estar dentro del service_cidr
}

  # MONITORING — Log Analytics
  oms_agent {
    log_analytics_workspace_id = var.log_analytics_id
  }

  tags = var.tags
}