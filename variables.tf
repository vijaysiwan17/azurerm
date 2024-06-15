variable "env" {
  type = string

}
variable "location" {
  type = string
}
variable "mytag" {
  type = map(string)
  default = {
    name = "test"
  }

}
variable "vnet_address_space" {
  type    = list(string)
  default = ["172.16.0.0"]
}


variable "public_subnet_prefixes" {
  type    = list(string)
  default = ["172.16.0.0/24", "172.16.1.0/24", "172.16.2.0/24"]
}
variable "private_subnet_prefixes" {
  type    = list(string)
  default = ["172.16.50.0/24", "172.16.51.0/24", "172.16.52.0/24"]
} 

  
