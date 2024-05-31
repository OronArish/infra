# cluster resource
resource "aws_eks_cluster" "eks-cluster" {
  name     = "oron-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }
  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  tags = merge(var.common_tags, { Name = "oron-eks-cluster" })
}

resource "aws_eks_addon" "eks-cluster-ebs" {
  cluster_name = aws_eks_cluster.eks-cluster.name
  addon_name   = "aws-ebs-csi-driver"
}

# node resource
resource "aws_eks_node_group" "worker_node_group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "oron-eks-node-group"
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids      = var.subnet_ids
  instance_types  = [var.instance_type]

  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.max_capacity
    min_size     = var.min_capacity
  }

  remote_access {
    source_security_group_ids = [aws_security_group.instance_sg.id]
    ec2_ssh_key               = aws_key_pair.ec2_key.key_name
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_node_group_role_attachment,
    aws_iam_role_policy_attachment.eks_cni_policy_attachment,
    aws_iam_role_policy_attachment.eks_ecr_policy_attachment,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]

  tags = merge(
    var.common_tags,
    {
      Name = "oron-eks-node-group"
    }
  )
}

resource "aws_key_pair" "ec2_key" {
  key_name   = "oron-nodes-key"
  public_key = tls_private_key.private_key.public_key_openssh
}

resource "tls_private_key" "private_key" {
  algorithm = "ED25519"
}

resource "aws_security_group" "instance_sg" {
  vpc_id = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    { Name = "oron-terraform-sg" }
  )
}



