# ## main.tf
# - 리소스를 정의한다.
# - variables.tf에서 선언한 변수를 사용하여 인프라를 구성한다.
# - --> gpu-vm, qdrant-vm 생성

terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }

    local = {
      source = "hashicorp/local"
    }

    null = {
      source = "hashicorp/null"
    }

    time = {
      source = "hashicorp/time"
    }
  }
}

# vi ~/.config/openstack/clouds.yaml
provider "openstack" {
  cloud = "openstack" # ~/.config/openstack/clouds.yaml 참조
}

# gpu-vm으로 사용할 인스턴스
resource "openstack_compute_instance_v2" "gpu-vm" {
  name      = "gpu-vm"
  flavor_id = var.gpu_flavor_id
  key_pair  = var.key_pair

  user_data = <<EOF
#cloud-config
runcmd:
  - sed -i 's/^PubkeyAuthentication no/PubkeyAuthentication yes/' /etc/ssh/sshd_config
  - systemctl restart ssh
EOF

  block_device {
    uuid                  = var.image_id
    source_type           = "image"
    destination_type      = "volume"
    volume_size           = var.volume_size
    boot_index            = 0
    delete_on_termination = true
  }

  network {
    uuid = var.network_id
  }

  security_groups = ["default"]
}

# qdrant-vm으로 사용할 인스턴스
resource "openstack_compute_instance_v2" "qdrant-vm" {
  name      = "qdrant-vm"
  flavor_id = var.qdrant_flavor_id
  key_pair  = var.key_pair

  user_data = <<EOF
#cloud-config
runcmd:
  - sed -i 's/^PubkeyAuthentication no/PubkeyAuthentication yes/' /etc/ssh/sshd_config
  - systemctl restart ssh
EOF

  block_device {
    uuid                  = var.image_id
    source_type           = "image"
    destination_type      = "volume"
    volume_size           = var.volume_size
    boot_index            = 0
    delete_on_termination = true
  }

  network {
    uuid = var.network_id
  }

  security_groups = ["default"]
}

resource "local_file" "ansible_inventory" {

  filename = "../ansible/inventory.ini"

  content = <<EOF
[instance]
gpu-vm ansible_host=${openstack_compute_instance_v2.gpu-vm.access_ip_v4}
qdrant-vm ansible_host=${openstack_compute_instance_v2.qdrant-vm.access_ip_v4}

[instance:vars]
ansible_user=ubuntu
ansible_connection=ssh
ansible_become=true
EOF

}

# resource "null_resource" "run_ansible" {
#
#   depends_on = [
#     local_file.ansible_inventory
#   ]
#
#   provisioner "local-exec" {
#     working_dir = "../ansible"
#
#     command = "ansible-playbook install-nginx.yml"
#   }
# }
