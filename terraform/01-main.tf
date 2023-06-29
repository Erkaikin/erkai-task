
terraform {
  required_version = ">= 1.4.2"
  backend "s3" {
    bucket = "erkai-s3"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

# region in aws
provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Name = "Erkai Erkinbekova"
      Owner = "Nati"
      Department = "DevOps"
      Temp = "true"
    }
  }
}

# getting eks credentials for helm provider
provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    token                  = data.aws_eks_cluster_auth.cluster.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  }
}

# getting eks credentials for kubernetes provider
provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}

data "aws_caller_identity" "current" {}
