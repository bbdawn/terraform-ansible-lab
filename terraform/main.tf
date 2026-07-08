terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
  }
}

provider "openstack" {
  cloud = "openstack" # ~/.config/openstack/clouds.yaml 참조
}

# GPU 인스턴스 (Ollama 실행)
resource "openstack_compute_instance_v2" "gpu" {
  name      = "rag-gpu"
  flavor_id = var.gpu_flavor_id
  image_id  = var.image_id
  key_pair  = var.key_pair

  network {
    name = var.network_name
  }

  security_groups = ["default", "ollama-access"]
}

# 일반 인스턴스 (Qdrant 실행)
resource "openstack_compute_instance_v2" "qdrant" {
  name      = "rag-qdrant"
  flavor_id = var.flavor_id
  image_id  = var.image_id
  key_pair  = var.key_pair

  network {
    name = var.network_name
  }

  security_groups = ["default", "qdrant-access"]
}