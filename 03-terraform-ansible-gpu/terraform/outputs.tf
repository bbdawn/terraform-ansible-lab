# ## outputs.tf
# - 생성된 리소스의 정보를 출력한다.
# - 다른 Terraform 설정이나 스크립트(Ansible 등)에서 사용할 값을 정의한다.
# - --> gpu_ip, qdrant_ip 출력

output "instance" {
  value = {
    "gpu-vm" = openstack_compute_instance_v2.gpu-vm.access_ip_v4
    "qdrant-vm" = openstack_compute_instance_v2.qdrant-vm.access_ip_v4
  }

  description = "IP list for ansible inventory"
}