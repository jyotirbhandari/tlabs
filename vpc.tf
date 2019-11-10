provider "aws" {
  region = var.region
}

module "vpc" {
  source = "github.com/jyotirbhandari/terraform/aws/modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  tags =  {
    Name  = "VPC for ${var.env}"
    Environment = var.env
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
  }
}



module "networking" {
  source = "github.com/jyotirbhandari/terraform/aws/modules/networking"
  vpc_id = "${module.vpc.vpc_id}"
  vpc_main_route_table = "${module.vpc.vpc_main_route_table}"
  vpc_public_subnets = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  vpc_private_subnets = ["10.0.20.0/24", "10.0.21.0/24", "10.0.22.0/24"]
  env = "${var.env}"
  tags_public = {
    Name  = "${var.env}-public"
    Environment = var.env
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
  }
  tags_private = {
    Name  = "${var.env}-private"
    Environment = var.env
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
  }
  tags_database = {
    Name  = "${var.env}-database"
    Environment = var.env
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
  }
  tags_elasticache = {
    Name  = "${var.env}-elasticache"
    Environment = var.env
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
  }
}
