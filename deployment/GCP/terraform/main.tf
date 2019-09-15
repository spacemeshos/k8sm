provider "google" {
  project = "${var.project_name}"
  zone    = "${var.zone}"
}

provider "google-beta" {
  project = "${var.project_name}"
  zone    = "${var.zone}"
}

resource "google_container_cluster" "cluster" {
  provider = "google-beta"
  name     = "${var.cluster_name}"
  location = "${var.zone}"
  min_master_version = "${var.k8s_version}"

  remove_default_node_pool = true
  initial_node_count = 1
  logging_service    = "none"
  monitoring_service = "none"

  #  VPC-native (alias IP)
  ip_allocation_policy {
    use_ip_aliases = true
  }

  default_max_pods_per_node = 110
}

resource "google_container_node_pool" "node_pool" {
  provider           = "google-beta"
  count              = "${length(var.node_pools)}"
  name               = "${lookup(var.node_pools[count.index],"name")}"
  location           = "${var.zone}"
  cluster            = "${google_container_cluster.cluster.name}"
  initial_node_count = "${lookup(var.node_pools[count.index],"initial_node_count")}"

  node_config {
    preemptible  = "${lookup(var.node_pools[count.index],"preemptible")}"
    machine_type = "${lookup(var.node_pools[count.index],"machine_type")}"
    image_type   = "${lookup(var.node_pools[count.index],"image_type")}"
    disk_type    = "${lookup(var.node_pools[count.index],"disk_type")}"
    disk_size_gb = "${lookup(var.node_pools[count.index],"disk_size_gb")}"
    labels       = "${var.node_pools_labels[lookup(var.node_pools[count.index],"name")]}"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append",
    ]
  }

  management {
    auto_repair  = "${lookup(var.node_pools[count.index],"auto_repair")}"
    auto_upgrade = "${lookup(var.node_pools[count.index],"auto_upgrade")}"
  }

  autoscaling {
    min_node_count = "${lookup(var.node_pools[count.index],"min_node_count")}"
    max_node_count = "${lookup(var.node_pools[count.index],"max_node_count")}"
  }
}


