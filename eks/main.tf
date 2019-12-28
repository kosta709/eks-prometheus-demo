locals {
  aws_region = "us-west-2"
  cluster_name = "eks-demo-1"
  eks_version = "1.14"
  vpc_id = "vpc-111"
  cluster_subnet_ids = ["subnet-", "subnet-"]
  
  node_subnet_ids = ["subnet-", "subnet-"]
  node_instance_type = "m5.large"
  node_max_size = 1
  node_min_size = 1
  spot_price = "0.1"

}

provider "aws" {
  region = local.aws_region
  version = "~> 2.0"
}

module "eks" {
  source  = "howdio/eks/aws"
  version = "2.0.0"

  name = local.cluster_name
  eks_version = local.eks_version
  vpc_id = local.vpc_id
  cluster_subnet_ids = local.cluster_subnet_ids

  node_subnet_ids = local.node_subnet_ids
  node_instance_type = local.node_instance_type
  node_max_size = local.node_max_size
  node_min_size = local.node_min_size
  spot_price = local.spot_price
  # insert the 1 required variable here
}

