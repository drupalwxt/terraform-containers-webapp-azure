# Storage Accounts

resource "azurerm_storage_account" "main" {
  name                     = "${replace(var.prefix, "-", "")}files"
  location                 = "${azurerm_resource_group.main.location}"
  resource_group_name      = "${azurerm_resource_group.main.name}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "drupal_settings" {
  name                  = "drupal-settings"
  resource_group_name   = "${azurerm_resource_group.main.name}"
  storage_account_name  = "${azurerm_storage_account.main.name}"
  container_access_type = "private"
}

resource "azurerm_storage_container" "public_files" {
  name                  = "files-public"
  resource_group_name   = "${azurerm_resource_group.main.name}"
  storage_account_name  = "${azurerm_storage_account.main.name}"
  container_access_type = "private"
}

resource "azurerm_storage_container" "private_files" {
  name                  = "files-private"
  resource_group_name   = "${azurerm_resource_group.main.name}"
  storage_account_name  = "${azurerm_storage_account.main.name}"
  container_access_type = "private"
}

resource "azurerm_storage_container" "nginx_config" {
  name                  = "config-nginx"
  resource_group_name   = "${azurerm_resource_group.main.name}"
  storage_account_name  = "${azurerm_storage_account.main.name}"
  container_access_type = "private"
}

resource "azurerm_storage_blob" "nginx_nginx_conf" {
  name                   = "nginx.conf"
  resource_group_name    = "${azurerm_resource_group.main.name}"
  storage_account_name   = "${azurerm_storage_account.main.name}"
  storage_container_name = "${azurerm_storage_container.nginx_config.name}"
  type                   = "block"
  source                 = "config/nginx/nginx.conf"
}

resource "azurerm_storage_blob" "nginx_mime_types" {
  name                   = "mime.types"
  resource_group_name    = "${azurerm_resource_group.main.name}"
  storage_account_name   = "${azurerm_storage_account.main.name}"
  storage_container_name = "${azurerm_storage_container.nginx_config.name}"
  type                   = "block"
  source                 = "config/nginx/mime.types"
}

resource "azurerm_storage_blob" "nginx_fastcgi_params" {
  name                   = "fastcgi_params"
  resource_group_name    = "${azurerm_resource_group.main.name}"
  storage_account_name   = "${azurerm_storage_account.main.name}"
  storage_container_name = "${azurerm_storage_container.nginx_config.name}"
  type                   = "block"
  source                 = "config/nginx/fastcgi_params"
}

resource "azurerm_storage_blob" "drupal_default_services_yml" {
  name                   = "default.services.yml"
  resource_group_name    = "${azurerm_resource_group.main.name}"
  storage_account_name   = "${azurerm_storage_account.main.name}"
  storage_container_name = "${azurerm_storage_container.drupal_settings.name}"
  type                   = "block"
  source                 = "config/drupal/default.services.yml"
}

resource "azurerm_storage_blob" "drupal_default_settings_php" {
  name                   = "default.settings.php"
  resource_group_name    = "${azurerm_resource_group.main.name}"
  storage_account_name   = "${azurerm_storage_account.main.name}"
  storage_container_name = "${azurerm_storage_container.drupal_settings.name}"
  type                   = "block"
  source                 = "config/drupal/default.settings.php"
}

resource "azurerm_storage_blob" "drupal_settings_php" {
  name                   = "settings.php"
  resource_group_name    = "${azurerm_resource_group.main.name}"
  storage_account_name   = "${azurerm_storage_account.main.name}"
  storage_container_name = "${azurerm_storage_container.drupal_settings.name}"
  type                   = "block"
  source                 = "config/drupal/settings.php"
}
