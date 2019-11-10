module "eks_cluster" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name = var.eks_cluster_name
  subnets      = flatten(module.networking.public_subnets)
  vpc_id       = module.vpc.vpc_id

  worker_groups = [
    {
      instance_type = "t2.small"
      asg_max_size  = 10
      asg_min_size  = 3
      asg_desired_capacity = 3
      autoscaling_enabled = true
      protect_from_scale_in = false
      subnets      = flatten(module.networking.private_subnets)
      tags = [{
        key                 = "foo"
        value               = "bar"
        propagate_at_launch = true
      }]
    }
  ]

  tags = {
    environment = var.env
  }
}
