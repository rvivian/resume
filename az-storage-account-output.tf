output "azure_resource_group" {
  value = azurerm_resource_group.rg.name
}

output "azure_cdn_profile_name" {
  value = azurerm_cdn_profile.cdn_profile.name
}

output "azure_cdn_endpoint" {
  value = azurerm_cdn_endpoint.cdn_endpoint.name
}