output "gpu_ip" {
  value       = openstack_compute_instance_v2.gpu.access_ip_v4
  description = "GPU 인스턴스 IP (Ansible inventory에 사용)"
}

output "qdrant_ip" {
  value       = openstack_compute_instance_v2.qdrant.access_ip_v4
  description = "Qdrant 인스턴스 IP"
}