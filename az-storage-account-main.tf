terraform {
  backend "azurerm" {}
}

locals {
  env_prefix              = "${var.shortcode}-${var.product}-${var.envname}-${var.location_short_code}"
  enf_prefix_no_separator = "${var.shortcode}${var.product}${var.envname}${var.location_short_code}"
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
  account_tier                     = "StandardV2"
  account_replication_type         = "LRS"
  cross_tenant_replication_enabled = false
  enable_https_traffic_only        = true
  static_website {
    index_document = "index.html"
  }
}

resource "azurerm_storage_container" "resume_web_container_dev" {
  name                  = "$web"
  container_access_type = "private"
  storage_account_name  = azurerm_storage_account.resume_storage_dev.name
}

resource "azurerm_storage_blob" "resume_blob_dev" {
  for_each = fileset(path.module, "site_data/*")

  name                   = trimprefix(each.key, "site_data/")
  storage_account_name   = azurerm_storage_account.resume_storage_dev.name
  storage_container_name = azurerm_storage_container.resume_web_container_dev.name
  type                   = "Block"
  content_md5            = filemd5(each.key)
  source                 = each.key
}

resource "azurerm_cdn_profile" "resume_cdn_profile_dev" {
  name                = "rv-resume-cdn-dev"
  location            = "global"
  resource_group_name = azurerm_resource_group.resume_rg_dev.name
  sku                 = "Standard_Microsoft"
}

resource "azurerm_cdn_endpoint" "resume_cdn_endpoint_dev" {
  name                = "rvresumedev"
  profile_name        = azurerm_cdn_profile.resume_cdn_profile_dev.name
  location            = azurerm_cdn_profile.resume_cdn_profile_dev.location
  resource_group_name = azurerm_resource_group.resume_rg_dev.name
  origin {
    name       = "rvresumewebdev-z1-web-core-windows-net"
    host_name  = "rvresumewebdev.z1.web.core.windows.net"
    http_port  = 80
    https_port = 443
  }
  origin_host_header     = "rvresumewebdev.z1.web.core.windows.net"
  is_compression_enabled = true
}

resource "azurerm_cdn_endpoint_custom_domain" "resume_custom_domain_dev" {
  name            = "resume-northof66-com"
  cdn_endpoint_id = azurerm_cdn_endpoint.resume_cdn_endpoint_dev.id
  host_name       = "resume.northof66.com"
  cdn_managed_https {
    certificate_type = "Dedicated"
    protocol_type    = "ServerNameIndication"
    tls_version      = "TLS12"
  }
}