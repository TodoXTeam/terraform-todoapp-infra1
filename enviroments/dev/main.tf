locals {
  common_tags = {
    "ManagedBy"   = "Terraform"
    "Owner"       = "TodoAppTeam"
    "Environment" = "dev"
  }
}

module "rg" {
  source      = "../../module/azurerm_resource_group"
  rg_name     = "rg-dev-todoapp17"
  rg_location = "centralindia"
  tags       = local.common_tags
}
module "storage_account" {
  depends_on = [module.rg]
  source     = "../../module/azurerm_storage_account"

  sa_name     = "stdevtodoapp17"   # 👈 Storage account name (globally unique hona chahiye)
  rg_name     = module.rg.rg_name
  rg_location = module.rg.rg_location   # 👈 Fix: "rg_location" pass karna hoga
  tags        = local.common_tags
}



module "acr" {
  depends_on = [module.rg]
  source     = "../../module/azurerm_container_registry"
  acr_name   = "acrdevtodoapp17"
  rg_name    = "rg-dev-todoapp17"
  location   = "centralindia"
  tags       = local.common_tags
}

module "sql_server" {
  depends_on      = [module.rg]
  source          = "../../module/azurerm_sql_server"
  sql_server_name = "sql-dev-todoapp17"
  rg_name         = "rg-dev-todoapp17"
  location        = "centralindia"
  admin_username  = "devopsadmin"
  admin_password  = "P@ssw01rd@123"
  tags            = local.common_tags
}

module "sql_db" {
  source       = "../../module/azurerm_sql_database"
  sql_db_name  = "sqldb-dev-todoapp17"
  server_id    = module.sql_server.server_id   # 👈 ye sahi hai
  max_size_gb  = "1"
  tags         = local.common_tags
}


module "aks" {
  depends_on = [module.rg]
  source     = "../../module/azurerm_kubernetes_cluster"
  aks_name   = "aks-dev-todoapp17"
  location   = "centralindia"
  rg_name    = "rg-dev-todoapp17"
  dns_prefix = "aks-dev-todoapp"
  tags       = local.common_tags
}
module "pip" {
  source   = "../../module/azurerm_public_ip"
  pip_name = "pip-dev-todoapp1235"
  rg_name  = "rg-dev-todoapp17"
  location = "centralindia"
  sku      = "Basic"
  tags     = local.common_tags
}
