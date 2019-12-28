locals {
  aws_region = "us-west-2"
  cluster_name = "eks-demo-1"
  eks_version = "1.14"

  vpc_id = "vpc-0f8bf60fa684501db"
  cluster_subnet_ids = ["subnet-0abcba65c7092a699", "subnet-069d090fd496afde8"]
  
  node_subnet_ids = ["subnet-0ea74b76c14bcc51d", "subnet-0345da9eceaf3ef8c"]
  node_group_name = "eks-demo-nodes-1"
  node_instance_type = "m5.large"
  node_max_size = 1
  node_min_size = 1
  spot_price = "0.1"
}

provider "aws" {
  region = local.aws_region
  version = "~> 2.0"
}

module "eks_cluster" {
  source  = "howdio/eks/aws//modules/cluster"
  version = "2.0.0"

  name = local.cluster_name
  eks_version = local.eks_version
  vpc_id = local.vpc_id
  subnet_ids = local.cluster_subnet_ids

  cluster_private_access = true
  # insert the 1 required variable here
}

module "eks_nodes" {
  source  = "howdio/eks/aws//modules/nodes"
  version = "2.0.0"

  name = local.node_group_name
  cluster_name        = module.eks_cluster.name
  cluster_endpoint    = module.eks_cluster.endpoint
  cluster_certificate = module.eks_cluster.certificate
  instance_profile    = module.eks_cluster.node_instance_profile
  security_groups     = [module.eks_cluster.node_security_group]

  subnet_ids          = local.node_subnet_ids
  instance_type = local.node_instance_type
  max_size = local.node_max_size
  min_size = local.node_min_size
  disk_size = "20"
  spot_price = local.spot_price
}

