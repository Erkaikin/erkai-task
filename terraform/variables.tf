variable "base_domain" {
  type    = string
  default = "erkai-task.com"
  description = "Base domain for our DNS records"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
  description = "AWS region to create our resources"
}
