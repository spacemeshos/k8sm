output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}


# output "kube2iam_arn" {
#     value = "${aws_iam_policy.kube2iam.arn}"
# }

# output "kube2iam_path" {
#     value = "/kube2iam_${var.cluster_name}/"
# }