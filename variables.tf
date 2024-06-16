variable "app_name" {
  default = "app"
}

variable "database_login" {
  default = "mysqladminun"

}
variable "database_password" {
  default = "sV2fMTherPIBzg1S"
}

variable "agent_count" {
  default = 1
}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "dns_prefix" {
  default = "wordpress"
}

variable "cluster_name" {
  default = "wordpress"
}

variable "resource_group_name" {
  default = "cuond"
}

variable "location" {
  default = "East US"
}

