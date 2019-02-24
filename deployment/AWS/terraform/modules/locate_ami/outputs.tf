output "regional_centos_ami_id" {
  value = "${data.aws_ami.centos.id}"
}

output "regional_ubuntu_ami_id" {
  value = "${data.aws_ami.ubuntu.id}"
}
