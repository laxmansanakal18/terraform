# MSSQL

resource "azurerm_mssql_server" "sqlserver" {
  name                         = "#{sqlservername}#"
  location                     = "#{location}#"
  resource_group_name          = "#{resourcegroupname}#"
  version                      = "12.0"
  administrator_login          = "#{sqladminuser}#"
  administrator_login_password = "#{sqladminpsw}#"
  minimum_tls_version          = "1.2"
  identity {
    type = "SystemAssigned"
  }
  tags = {
    environment = "#{env}#"
  }
}

output "serverID" {
  value = azurerm_mssql_server.sqlserver.id
}

resource "azurerm_mssql_database" "sql-db" {
  depends_on          = [ azurerm_mssql_server.sqlserver ]
  name                = "mssql-#{env}#-db"
  server_id           = azurerm_mssql_server.sqlserver.id
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  license_type        = "LicenseIncluded"
  sku_name            = "#{sqlsku}#"
  zone_redundant      = false
  short_term_retention_policy {
    retention_days = 7
  }
  long_term_retention_policy {
    weekly_retention  = "P2W"
    monthly_retention = "P6M"
    yearly_retention  = "P0Y"
    week_of_year      = "1"  
  }
  tags = {
    environment = "#{env}#"
  }
  lifecycle {
    prevent_destroy = true
  }
}