terraform {
  backend "remote" {
    organization = "northof66"
    workspaces {
      name = "resume"
    }
  }
}

locals {
  env_prefix              = "${var.shortcode}-${var.product}-${var.envname}-${var.location_short_code}"
  env_prefix_no_separator = "${var.shortcode}${var.product}${var.envname}${var.location_short_code}"
  domain_name             = var.envname == "prod" ? "${var.product}" : "${var.product}-${var.envname}"

}

resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = "${local.env_prefix}-rg"
}

resource "azurerm_storage_account" "storage_account" {
  name                             = local.env_prefix_no_separator
  resource_group_name              = azurerm_resource_group.rg.name
  location                         = azurerm_resource_group.rg.location
  access_tier                      = "Cool"
  account_tier                     = "Standard"
  account_replication_type         = "LRS"
  cross_tenant_replication_enabled = false
  enable_https_traffic_only        = true
  static_website {
    index_document = "index.html"
  }
}

resource "azurerm_cdn_profile" "cdn_profile" {
  name                = "${local.env_prefix}-cdnprofile"
  location            = "global"
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard_Microsoft"
}

resource "azurerm_cdn_endpoint" "cdn_endpoint" {
  name                = local.env_prefix_no_separator
  profile_name        = azurerm_cdn_profile.cdn_profile.name
  location            = azurerm_cdn_profile.cdn_profile.location
  resource_group_name = azurerm_resource_group.rg.name
  origin {
    name       = "${local.env_prefix_no_separator}-z1-web-core-windows-net"
    host_name  = "${local.env_prefix_no_separator}.z1.web.core.windows.net"
    http_port  = 80
    https_port = 443
  }
  origin_host_header = "${local.env_prefix_no_separator}.z1.web.core.windows.net"
}

resource "azurerm_cdn_endpoint_custom_domain" "custom_domain" {
  name            = "${local.domain_name}-northof66-com"
  cdn_endpoint_id = azurerm_cdn_endpoint.cdn_endpoint.id
  host_name       = "${local.domain_name}.northof66.com"
  cdn_managed_https {
    certificate_type = "Dedicated"
    protocol_type    = "ServerNameIndication"
    tls_version      = "TLS12"
  }
}

resource "azurerm_cosmosdb_account" "counter_db" {
  name                = "${local.env_prefix}-account"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  offer_type          = "Standard"
  capabilities {
    name = "EnableServerless"
  }
  capabilities {
    name = "EnableTable"
  }
  backup {
    type = "Continuous"
  }
  geo_location {
    location          = azurerm_resource_group.rg.location
    failover_priority = 0
  }
  consistency_policy {
    consistency_level = "Session"
  }
}

resource "azurerm_cosmosdb_table" "counter_table" {
  name                = "${local.env_prefix}-table"
  resource_group_name = azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.counter_db.name

}