
output "azurenetwork-id" {
  value = azurerm_virtual_network.example.id
}

output "subnetA-id" {
  value = azurerm_subnet.subnetA.id
}

output "subnetB-id" {
  value = azurerm_subnet.subnetB.id
}

output "public-ip-id" {
  value = azurerm_public_ip.apppublicip.id
}

output "rg-id" {
  value = azurerm_resource_group.rgname.id
}

output "nsg-id" {
  value = azurerm_network_security_group.nsgram.id
}

output "nic-id" {
  value = azurerm_network_interface.ramnic.id
}