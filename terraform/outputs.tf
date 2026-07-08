# ## outputs.tf
# - 생성된 리소스의 정보를 출력한다.
# - 다른 Terraform 설정이나 스크립트(Ansible 등)에서 사용할 값을 정의한다.
# - --> gpu_ip, qdrant_ip 출력

output "gpu_ip" {
  value       = openstack_compute_instance_v2.gpu.access_ip_v4
  description = "GPU 인스턴스 IP (Ansible inventory에 사용)"
}

output "qdrant_ip" {
  value       = openstack_compute_instance_v2.qdrant.access_ip_v4
  description = "Qdrant 인스턴스 IP"
}