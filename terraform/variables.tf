# ## variables.tf
# - 사용할 변수를 선언한다.
# --> image_id, flavor_id, network_name, key_pair 등을 선언

variable "gpu_flavor_id" {
  description = "MIG 슬라이스가 포함된 GPU 플레이버 ID"
}

variable "flavor_id" {
  description = "일반 인스턴스 플레이버 ID"
}

variable "image_id" {
  description = "Ubuntu 22.04 이미지 ID"
}

variable "key_pair" {
  description = "SSH 키페어 이름"
}

variable "network_name" {
  description = "인스턴스를 연결할 네트워크 이름"
}