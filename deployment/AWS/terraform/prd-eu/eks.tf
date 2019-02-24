

resource "aws_security_group" "eks-workers-controlPlaneSg" {
  description = "Access to workers from within the vpc / via vpn"
  name_prefix = "all_worker_management"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
      "172.16.0.0/12",
      "192.168.0.0/16",
    ]
  }
}

locals {
  # the commented out worker group list below shows an example of how to define
  # multiple worker groups of differing configurations
  kubeconfig_aws_authenticator_env_variables = [
    {
      AWS_PROFILE = "${var.profile}"
    },
  ]

  worker_groups = [
    {
      asg_desired_capacity          = 3
      asg_max_size                  = 5
      asg_min_size                  = 3
      key_name                      = "${aws_key_pair.spacemesh-eks.key_name}"
      instance_type                 = "t3.large"
      name                          = "standard-cpu-workloads"
      subnets                       = "${join(",", module.vpc.private_subnets)}"
      additional_security_group_ids = "${aws_security_group.allow_office_to_all_sg.id}"
    },
  ]
}

module "eks" {
  source                               = "terraform-aws-modules/eks/aws"
  cluster_name                         = "${var.cluster_name}"
  cluster_version                      = "${var.cluster_version}"
  subnets                              = ["${module.vpc.private_subnets}"]
  tags                                 = "${var.cluster_tags}"
  vpc_id                               = "${module.vpc.vpc_id}"
  worker_groups                        = "${local.worker_groups}"
  worker_group_count                   = "1"
  worker_additional_security_group_ids = ["${aws_security_group.eks-workers-controlPlaneSg.id}"]
  map_users                            = "${var.map_users}"
  map_roles                            = "${var.map_roles}"
}