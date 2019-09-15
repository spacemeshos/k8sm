variable "project_name" {
  default = "spacemesh-tst"
}

variable "cluster_name" {
  default = "terraform-created-cluster"
}

variable "zone" {
  default = "us-west1-a"
}

variable "k8s_version" {
  default = "1.13.7-gke.24"
}

variable "node_pools" {
  default = [
    {
      name               = "infra-pool"
      min_node_count     = 1
      max_node_count     = 10
      initial_node_count = 6
      machine_type       = "n1-highmem-4"
      image_type         = "COS"
      disk_size_gb       = 300
      disk_type          = "pd-ssd"
      preemptible        = false
      auto_repair        = true
      auto_upgrade       = true
    },
    {
      name               = "test-pool"
      min_node_count     = 1
      max_node_count     = 300
      initial_node_count = 1
      machine_type       = "n1-standard-1"
      image_type         = "COS"
      disk_size_gb       = 50
      disk_type          = "pd-standard"
      preemptible        = false
      auto_repair        = true
      auto_upgrade       = true
    },
  ]
}

variable "node_pools_labels" {
  type        = "map"
  description = "Map of maps containing node labels by node-pool name"

  default = {
    infra-pool = {
      role = "infra"
    }

    test-pool = {
      role = "tests"
    }
  }
}
