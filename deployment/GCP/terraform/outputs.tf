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

locals {
  kubeconfig = <<KUBECONFIG
apiVersion: v1
kind: Config
clusters:
- name: ${google_container_cluster.cluster.name}
  cluster:
    server: https://${google_container_cluster.cluster.endpoint}
    certificate-authority-data: ${google_container_cluster.cluster.master_auth.0.cluster_ca_certificate}
users:
- name: ${google_container_cluster.cluster.name}-user
  user:
    access-token: '{.credential.access_token:}'
    cmd-args: config config-helper --format=json
    cmd-path: /usr/lib/google-cloud-sdk/bin/gcloud
    expiry: '{.credential.token_expiry}'
    expiry-key: '{.credential.token_expiry}'
    token-key: '{.credential.access_token}'
current-context: ${google_container_cluster.cluster.name}-context
contexts:
- name: ${google_container_cluster.cluster.name}-context
  context:
    cluster: ${google_container_cluster.cluster.name}
    user: ${google_container_cluster.cluster.name}-user    
KUBECONFIG
}

output "kubeconfig" {
  value = "${local.kubeconfig}"
}
