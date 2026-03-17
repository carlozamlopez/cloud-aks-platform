terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-backend"
    storage_account_name = "stterraformbackendmx"
    container_name       = "tfstate"
    key                  = "cloud-aks-platform.terraform.tfstate"
  }
}