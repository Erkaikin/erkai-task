#####################################
### VPC MODULE
#####################################

module "vpc" {
  source             = "terraform-aws-modules/vpc/aws"
  version            = "5.0.0"
  name               = "VPC"
  cidr               = "10.0.0.0/16"
  enable_nat_gateway = true
  single_nat_gateway = true
  create_database_subnet_route_table = false
  azs                = slice(data.aws_availability_zones.available.names, 0, 2)
  private_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets     = ["10.0.4.0/24", "10.0.5.0/24"]

}
