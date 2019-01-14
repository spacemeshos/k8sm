# resource "aws_security_group" "db-access" {
#     name        = "db-access"
#     description = "RDS related rules"
#     vpc_id      = "vpc-02857467"

#     ingress {
#         from_port       = 22
#         to_port         = 22
#         protocol        = "tcp"
#         cidr_blocks     = ["82.166.134.98/32"]
#         security_groups = ["sg-948b24f1"]
#         self            = false
#         description     = "Haggai home"
#     }

#     ingress {
#         from_port       = 3306
#         to_port         = 3306
#         protocol        = "tcp"
#         cidr_blocks     = [ "82.166.134.98/32", "37.142.12.114/32", "172.31.16.0/20", "172.31.0.0/20", "172.31.32.0/20", "199.203.227.60/32", "31.168.244.218/32", "109.67.60.126/32", "132.66.222.87/32", "141.226.243.96/32", "81.218.136.55/32", "82.166.68.50/32"]
#         security_groups = ["sg-948b24f1", "${aws_security_group.allow_office_to_all_sg.id}"]
#         self            = true
#     }

#     ingress {
#         from_port       = -1
#         to_port         = -1
#         protocol        = "icmp"
#         cidr_blocks     = ["82.166.134.98/32"]
#         description     = "Haggai home"
#     }


#     egress {
#         from_port       = 0
#         to_port         = 0
#         protocol        = "-1"
#         cidr_blocks     = ["0.0.0.0/0"]
#     }

# }

resource "aws_security_group" "allow_office_to_all_sg" {
  name_prefix = "allow_office_to_all_sg"
  description = "Allow select Ip addresses to ssh"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "82.166.134.98/32",
    ]
  }
}
