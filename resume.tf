terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.24"
    }
  }
  required_version = ">= 1.2.4"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resume_rg_dev" {
  location = "westus3"
  name     = "resume-rg-dev"
}

resource "azurerm_storage_account" "resume_storage_dev" {
  name                             = "rvresumewebdev"
  resource_group_name              = azurerm_resource_group.resume_rg_dev.name
  location                         = azurerm_resource_group.resume_rg_dev.location
  access_tier                      = "Cool"
  account_tier                     = "Standard"
  account_replication_type         = "LRS"
  cross_tenant_replication_enabled = false
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