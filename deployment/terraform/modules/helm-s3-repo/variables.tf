variable "bootstrap" {
  description = "Whether bootstrap basic infra or not"
  default     = 0
}

variable "operators" {
  type = "list"
}

variable "bucket" {}
variable "profile" {}
variable "region" {}

variable "helm_repo_keys" {
  description = "the name of the repos you want under the s3 bucket"
  type = "list"
  default = [ 
    "stable", 
    "incubator", 
  ]
}