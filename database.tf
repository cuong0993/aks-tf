resource "azurerm_mysql_flexible_server" "wordpress" {
  resource_group_name = azurerm_resource_group.wordpress.name
  name                = "wordpress-mysql-server"
  location            = azurerm_resource_group.wordpress.location
  version             = "8.0.21"

  administrator_login    = var.database_login
  administrator_password = var.database_password

  sku_name = "B_Standard_B1s"
  storage {
    size_gb           = "20"
    auto_grow_enabled = false
  }
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  zone                         = 3
}

resource "azurerm_mysql_flexible_database" "wordpress" {
  name                = "wordpress-mysql-db"
  resource_group_name = azurerm_resource_group.wordpress.name
  server_name         = azurerm_mysql_flexible_server.wordpress.name
  charset             = "utf8mb4"
  collation           = "utf8mb4_general_ci"
}

resource "azurerm_mysql_flexible_server_firewall_rule" "wordpress" {
  name                = "wordpress-mysql-firewall-rule"
  resource_group_name = azurerm_resource_group.wordpress.name
  server_name         = azurerm_mysql_flexible_server.wordpress.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

resource "azurerm_mysql_flexible_server_configuration" "disable_tls" {
  name                = "require_secure_transport"
  resource_group_name = azurerm_resource_group.wordpress.name
  server_name         = azurerm_mysql_flexible_server.wordpress.name
  value               = "off"
}
