#####################################
### EKS MODULE
#####################################

module "eks" {
  source                          = "terraform-aws-modules/eks/aws"
  cluster_name                    = "eks"
  version                         = "19.15.3"
  cluster_version                 = "1.24"
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  vpc_id                          = module.vpc.vpc_id
  subnet_ids                      = module.vpc.private_subnets
  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  eks_managed_node_groups = {
    internal-service = {
      min_size                     = 2
      max_size                     = 3
      desired_size                 = 2
      disk_size                    = 50
      instance_types               = ["t3.medium"]
      capacity_type                = "SPOT"
      subnet_ids                   = module.vpc.private_subnets
      iam_role_additional_policies = { AmazonElasticContainerRegistryPublicReadOnly = "arn:aws:iam::aws:policy/AmazonElasticContainerRegistryPublicReadOnly" }
    }
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name
  depends_on = [
    module.eks.cluster_name
  ]
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
  depends_on = [
    module.eks.cluster_name
  ]
}

data "aws_availability_zones" "available" {}