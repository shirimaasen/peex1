terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.52.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr_block      = var.vpc_cidr_block
  subnet_cidr_block   = var.subnet_cidr_block
  vpc_name            = var.vpc_name
  subnet_name         = var.subnet_name
  igw_name            = var.igw_name
  route_table_name    = var.route_table_name
}

resource "random_password" "this" {
  length  = var.passwd_len
  special = true
}

module "sql_creds" {
  source       = "./modules/secrets"
  secret_name  = var.sql_creds_name
  secret_description = "MySQL credentials"
  secret_string = jsonencode({
    username = var.secret_username,
    password = random_password.this.result
  })
  lifecycle_ignore_changes = false
}

module "ec2_key_pair" {
  source       = "./modules/secrets"
  secret_name  = var.ec2_key_pair_name
  secret_description = "EC2 key pair"  
  secret_string = jsonencode({
    key = var.ec2_key_pair_value
  })
  lifecycle_ignore_changes = false
}

module "iam" {
  source                = "./modules/iam"
  policy_name           = var.policy_name
  secret_arn            = "arn:aws:secretsmanager:${var.region}:*:secret:${var.secret_username}-*"
  instance_profile_name = var.instance_profile_name
  role_name             = var.role_name
}

module "ec2" {
  source                 = "./modules/ec2"
  ami_name               = var.ami_name
  virtualization_type    = var.virtualization_type
  owners                 = var.owners
  sg_name                = var.sg_name
  sg_tag                 = var.sg_tag
  vpc_id                 = module.vpc.vpc_id
  subnet_id              = module.vpc.subnet_id
  private_ip             = var.private_ip
  instance_type          = var.instance_type
  key_name               = jsondecode(module.ec2_key_pair.secret_string).key
  iam_instance_profile   = var.instance_profile_name
  role_name              = var.role_name
  instance_profile_name  = var.instance_profile_name
  ec2_tags               = {
    Name = "peex1-secret-instance"
  }
  user_data = file("${path.root}/assets/get_secret.sh")
}
