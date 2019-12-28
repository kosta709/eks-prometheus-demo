# EKS + Prometheus


### Prerequisites:

##### VPC and Subnets prerequisites:
see https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html

* enable DNS Resolution and DNS Hostnames for VPC
* tags for vpc and all subnets:
  - kubernetes.io/cluster/<cluster-name> = shared
* tags for internal subnets:
  - kubernetes.io/role/internal-elb = 1
* tags for public subnets:
  - kubernetes.io/role/elb = 1


### EKS Parameters
https://registry.terraform.io/modules/howdio/eks/aws/2.0.0