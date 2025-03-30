provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "eu-west-1-vpc"
  cidr = "10.1.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b"]
  private_subnets = ["10.1.1.0/24", "10.1.2.0/24"]
  public_subnets  = ["10.1.101.0/24", "10.1.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Project = "multi-region"
    Region  = "eu-west-1"
  }
}

resource "aws_iam_role" "eks_cluster" {
  name = "eks-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role.json
}

resource "aws_iam_role" "eks_nodes" {
  name = "eks-node-role"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role.json
}

data "aws_iam_policy_document" "eks_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com", "ec2.amazonaws.com"]
    }
  }
}

module "eks" {
  source = "../modules/eks-cluster"

  cluster_name     = "eks-eu-west-1"
  cluster_role_arn = aws_iam_role.eks_cluster.arn
  node_role_arn    = aws_iam_role.eks_nodes.arn
  subnet_ids       = module.vpc.private_subnets

  tags = {
    Project = "multi-region"
    Region  = "eu-west-1"
  }
}

data "aws_lb" "user_alb" {
  name = "user-alb"
}

