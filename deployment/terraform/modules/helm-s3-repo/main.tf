# KMS Key
provider "aws" {
  profile = "${var.profile}"
  region = "${var.region}"
}

resource "aws_kms_key" "tf_enc_key" {
  count = "${var.bootstrap}"

  description             = "Global Helm repo encryption key"
  deletion_window_in_days = 30

  tags {
    Origin = "Terraform"
  }
}

# S3 Bucket
resource "aws_s3_bucket" "helm_repo" {
  count = "${var.bootstrap}"

  bucket = "${var.bucket}"
  acl    = "private"
  region = "${var.region}"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "expire"
    enabled = true

    noncurrent_version_expiration {
      days = 90
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${aws_kms_key.tf_enc_key.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags {
    Origin = "Terraform"
  }
}

# S3 Bucket Policy

data "aws_iam_user" "operators" {
  count = "${length(var.operators)}"

  user_name = "${var.operators[count.index]}"
}

data "template_file" "operator_arn" {
  count    = "${length(var.operators)}"
  template = "\"$${arn}\""

  vars {
    arn = "${element(data.aws_iam_user.operators.*.arn, count.index)}"
  }
}

data "template_file" "helm_repo_policy" {
  template = "${file("${path.module}/templates/policy.json.tpl")}"

  vars {
    bucket    = "${aws_s3_bucket.helm_repo.arn}"
    operators = "${join(",", data.template_file.operator_arn.*.rendered)}"
  }
}

resource "aws_s3_bucket_policy" "helm_repo" {
  count = "${var.bootstrap}"

  bucket = "${aws_s3_bucket.helm_repo.id}"
  policy = "${data.template_file.helm_repo_policy.rendered}"
}

resource "aws_s3_bucket_object" "repo_keys" {
    count = "${length(var.helm_repo_keys)}"
    bucket = "${aws_s3_bucket.helm_repo.id}"
    acl    = "private"
    key    = "charts/${element(var.helm_repo_keys, count.index)}"
    source = "/dev/null"
    depends_on = [ "aws_s3_bucket.helm_repo" ]
}