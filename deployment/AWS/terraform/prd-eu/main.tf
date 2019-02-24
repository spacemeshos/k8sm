terraform {
  backend "s3" {
    key = "prd-eu/terraform.tfstate"
    region = "eu-west-1"
  }
  # required_version = ">= 0.11.7"
}

provider "aws" {
  version = ">= 1.24.0"
  region  = "${var.region}"
}

data "aws_availability_zones" "available" {}

resource "aws_key_pair" "spacemesh-eks" {
  key_name   = "spacemesh-eks"
  public_key = "${var.eks_support_pubkey}"
}

# resource "aws_eip" "edc_nat_gw" {
#   # count = 1
#   vpc = true
# }

module "vpc" {
  source              = "terraform-aws-modules/vpc/aws"
  version             = "1.14.0"
  name                = "prd-eu-vpc"
  cidr                = "${var.vpc_cidr_block}"
  azs                 = ["${data.aws_availability_zones.available.names[0]}", "${data.aws_availability_zones.available.names[1]}", "${data.aws_availability_zones.available.names[2]}"]
  public_subnets      = "${var.public_subnets}"
  private_subnets     = "${var.private_subnets}"
  enable_dns_hostnames = true
  enable_nat_gateway  = true
  single_nat_gateway  = true
  # reuse_nat_ips       = true
  # external_nat_ip_ids = ["${aws_eip.edc_nat_gw.id}"]
  tags                = "${merge(var.cluster_tags, map("kubernetes.io/cluster/${var.cluster_name}", "shared"))}"
}
