# ## outputs.tf
# - 생성된 리소스의 정보를 출력한다.
# - 다른 Terraform 설정이나 스크립트(Ansible 등)에서 사용할 값을 정의한다.
# - --> gpu_ip, qdrant_ip 출력

output "pool_member_1_ip" {
  value       = openstack_compute_instance_v2.pool-member-1.access_ip_v4
  description = "pool member 1 IP (Ansible inventory에 사용)"
}

output "pool_member_2_ip" {
  value       = openstack_compute_instance_v2.pool-member-2.access_ip_v4
  description = "pool member 2 IP (Ansible inventory에 사용)"
}

output "pool_member_3_ip" {
  value       = openstack_compute_instance_v2.pool-member-3.access_ip_v4
  description = "pool member 1 IP (Ansible inventory에 사용)"
}

output "pool_member_4_ip" {
  value       = openstack_compute_instance_v2.pool-member-4.access_ip_v4
  description = "pool member 2 IP (Ansible inventory에 사용)"
}