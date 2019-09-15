output "cluster_api_endpoint" {
  value = "${google_container_cluster.cluster.endpoint}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.cluster.master_auth.0.cluster_ca_certificate}"
}

output "cluster_zone" {
  value = "${google_container_cluster.cluster.zone}"
}

output "cluster_name" {
  value = "${google_container_cluster.cluster.name}"
}

