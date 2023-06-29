#####################################
### ECR MODULE
#####################################

module "ecr" {
  name    = "ecr"
  source  = "cloudposse/ecr/aws"
  version = "0.38.0"
  image_names = ["application"]
  use_fullname = true
  force_delete = true
  image_tag_mutability = "MUTABLE"
}