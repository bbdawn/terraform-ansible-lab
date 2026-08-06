# ## main.tf
# - 리소스를 정의한다.
# - variables.tf에서 선언한 변수를 사용하여 인프라를 구성한다.
# - --> pool-member-1, pool-member-2 생성

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

# loadbalancer pool member1로 사용할 인스턴스
resource "openstack_compute_instance_v2" "pool-member-1" {
  name      = "pool-member-1"
  flavor_id = var.flavor_id
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

# loadbalancer pool member2로 사용할 인스턴스
resource "openstack_compute_instance_v2" "pool-member-2" {
  name      = "pool-member-2"
  flavor_id = var.flavor_id
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
[pool_members]
pool-member-1 ansible_host=${openstack_compute_instance_v2.pool-member-1.access_ip_v4}
pool-member-2 ansible_host=${openstack_compute_instance_v2.pool-member-2.access_ip_v4}

[pool_members:vars]
ansible_user=ubuntu
ansible_connection=ssh
ansible_become=true
EOF

}

resource "null_resource" "run_ansible" {

  depends_on = [
    local_file.ansible_inventory
  ]

  provisioner "local-exec" {
    working_dir = "../ansible"

    command = "ansible-playbook install-nginx.yml"
  }
}
