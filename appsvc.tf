# Azure App Service

resource "azurerm_app_service_plan" "main" {
  name                = "${var.prefix}-asp"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S3"
  }
}

resource "azurerm_app_service" "main" {
  name                = "${var.prefix}-appservice"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  app_service_plan_id = "${azurerm_app_service_plan.main.id}"

  site_config {
    app_command_line = ""
    linux_fx_version = "COMPOSE|${filebase64("config/docker-compose.yml")}"
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }

  storage_account {
    name         = "drupal_settings"
    type         = "AzureBlob"
    account_name = "${azurerm_storage_account.main.name}"
    share_name   = "${azurerm_storage_container.drupal_settings.name}"
    access_key   = "${azurerm_storage_account.main.primary_access_key}"
  }

  storage_account {
    name         = "files_public"
    type         = "AzureBlob"
    account_name = "${azurerm_storage_account.main.name}"
    share_name   = "${azurerm_storage_container.public_files.name}"
    access_key   = "${azurerm_storage_account.main.primary_access_key}"
  }

  storage_account {
    name         = "files_private"
    type         = "AzureBlob"
    account_name = "${azurerm_storage_account.main.name}"
    share_name   = "${azurerm_storage_container.private_files.name}"
    access_key   = "${azurerm_storage_account.main.primary_access_key}"
  }

  storage_account {
    name         = "config_nginx"
    type         = "AzureBlob"
    account_name = "${azurerm_storage_account.main.name}"
    share_name   = "${azurerm_storage_container.nginx_config.name}"
    access_key   = "${azurerm_storage_account.main.primary_access_key}"
  }
}
