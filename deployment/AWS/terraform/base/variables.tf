# general / state related vars
variable "env" {
  type        = "string"
  description = "environment dev,stg,prod etc"
  default     = "prod"
}

variable "operators" {
  type = "list"

  default = [
    "automation",
  ]
}
variable "primary_public_domain" {
  default = "lab.spacemesh.io"
}
variable "key" {
  default = "base"
}

variable "bucket" {
  description = "Terraform state s3 bucket"
  default     = "spacemesh-lab-tfstate"
}

variable "dynamodb_table" {
  default = "TerraformStatelock"
}

# Kubernetes / vpc related vars
variable "vpc_cidr_block" {
  default = "172.31.0.0/16"
}

variable "cluster_name" {
  default = "spacemesh-lab"
}

variable "cluster_tags" {
  default = {
    GithubRepo = "k8sm"
    GithubOrg  = "spacemeshos"
    Workspace  = "spacemesh-prd-eu"
  }
}
variable "cluster_version" {
  default = "1.11"
}

variable "kubeconfig_output_path" {
  default = "../"
}

variable "create_elb_service_linked_role" {
  default = true
}
variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type        = "list"

  default = [
    {
      user_arn = "arn:aws:iam::534354616613:user/automation"
      username = "automation"
      group    = "system:masters"
    },
  ]
}

variable "map_roles" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type        = "list"

  default = [
    {
      user_arn = "arn:aws:iam::534354616613:group/admins"
      username = "admins"
      group    = "system:masters"
    },
  ]
}


variable "eks_support_pubkey" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1n+8qemM7qY81T55GG79px7WpzUPiYudGN2qLI8lfNr+Zcr+ZeEAlFZvqT5GGt067J9DUilzff5XHIMNf+RMcT0Yb1Gm5St0W7dPsG1qeOCNueWPvd+ntoLkskfhCicUw0lsTzslgGR3Owlv+85ksdEg0kJpu1pifAJRwMM17xqExgPXJvbHahj5SbVM6l5yIKRqVZUdynINkSxHcCrjeyvIQZo5sDVy921wbRyKhNCXxRe6Nmdqh7Co1UkRUyyEdh/3cMrH9rqsFWZxjWHe08S4gCrvPWf2bYeMKvPA8ziku8uUxw7TMdIUXbQBZGk6BJt/XWifbfTT71JcbOilv hagzag@Haggais-MacBook-Pro.local"
}

variable "bastion_instance_type" {
  default = "t2.small"
}

# variable "install_helm" {
#   default = true
# }


# RDS
variable "prod_rds_common_name" {
  default = "lightapp"
}

variable "private_subnets" {
  default = ["172.31.48.0/20", "172.31.64.0/20", "172.31.80.0/20"]
}

variable "public_subnets" {
  default = ["172.31.0.0/20", "172.31.16.0/20", "172.31.32.0/20"]
}

# variable "database_subnets" {
#   default = ["172.30.6.0/24", "172.30.7.0/24", "172.30.8.0/24"]
# }
