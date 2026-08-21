# ## variables.tf
# - 사용할 변수를 선언한다.
# --> image_id, flavor_id, network_id, key_pair 등을 선언

variable "gpu_flavor_id" {
  description = "gpu instance flavor id"
}

variable "qdrant_flavor_id" {
  description = "qdrant instance flavor id"
}

variable "key_pair" {
  description = "OpenStack keypair name"
  type        = string
}

variable "image_id" {
  description = "Ubuntu 22.04 image id"
}

variable "network_id" {
  description = "Openstack network id"
}

variable "volume_size" {
  description = "booting volume size(GB)"
  type        = number
}