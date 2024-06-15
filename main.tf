
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.108.0"
    }
  }
}

provider "azurerm" {
    features {
      
    }
  # Configuration options
}




resource "resource_group_name" "myrg" {
    name = "${var.env}-rg"
  location = var.location
  tags = var.mytag
}

resource "azurerm_virtual_network" "muraleevnet" {
    name = "${var.env}-vnet"
  address_space = var.vnet_address_space
  location = var.location
  resource_group_name = resource_group_name.myrg.name
  tags = var.mytag
}
  
resource "azurerm_subnet" "public1subnet" {
    name = "${var.env}-public1subnet"
  resource_group_name = resource_group_name.myrg.name
  virtual_network_name = azurerm_virtual_network.muraleevnet.name
  address_prefixes = var.public_subnet_prefixes[0]
}

resource "azurerm_subnet" "public2subnet" {
    name = "${var.env}-public2subnet"
  resource_group_name = resource_group_name.myrg.name
  virtual_network_name = azurerm_virtual_network.muraleevnet.name
  address_prefixes = var.public_subnet_prefixes[1]
}
resource "azurerm_subnet" "public3subnet" {
    name = "${var.env}-public3subnet"
  resource_group_name = resource_group_name.myrg.name
  virtual_network_name = azurerm_virtual_network.muraleevnet.name
  address_prefixes = var.public_subnet_prefixes[2]
}
# private subnet 


resource "azurerm_subnet" "private1subnet" {
    name = "${var.env}-private1subnet"
  resource_group_name = resource_group_name.myrg.name
  virtual_network_name = azurerm_virtual_network.muraleevnet.name
  address_prefixes = var.private_subnet_prefixes[0]
}
resource "azurerm_subnet" "private2subnet" {
    name = "${var.env}-private2subnet"
  resource_group_name = resource_group_name.myrg.name
  virtual_network_name = azurerm_virtual_network.muraleevnet.name
  address_prefixes = var.private_subnet_prefixes[1]
}
resource "azurerm_subnet" "private3subnet" {
    name = "${var.env}-private3subnet"
  resource_group_name = resource_group_name.myrg.name
  virtual_network_name = azurerm_virtual_network.muraleevnet.name
  address_prefixes = var.private_subnet_prefixes[2]
}
resource "azurerm_nat_gateway" "mynetgw" {
    name = "${var.env}-gw"
  location = var.location
  resource_group_name = resource_group_name.myrg.name
  tags = var.mytag
 
}

resource "azurerm_public_ip" "mynetgwip" {
    name = "${var.env}-natgwip"
  location = var.location
  resource_group_name = resource_group_name.myrg.name
  allocation_method = "Static"
  tags = var.mytag
}
  
resource "azurerm_nat_gateway_public_ip_association" "mynatgwipassociation" {
    nat_gateway_id = azurerm_nat_gateway.mynetgw.id
  public_ip_address_id = azurerm_public_ip.mynetgwip.id
}

  
resource "azurerm_subnet_nat_gateway_association" "natsubnetassociation1" {
    subnet_id = azurerm_subnet.private1subnet.id    
  nat_gateway_id = azurerm_nat_gateway.mynetgw.id
}
  
    
resource "azurerm_subnet_nat_gateway_association" "natsubnetassociation2" {
    subnet_id = azurerm_subnet.private2subnet.id    
  nat_gateway_id = azurerm_nat_gateway.mynetgw.id
}
  
resource "azurerm_subnet_nat_gateway_association" "natsubnetassociation3" {
    subnet_id = azurerm_subnet.private3subnet.id    
  nat_gateway_id = azurerm_nat_gateway.mynetgw.id
}

