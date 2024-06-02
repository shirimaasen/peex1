provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr_block      = var.vpc_cidr_block
  subnet_cidr_block   = var.subnet_cidr_block
  vpc_name            = "peex1-vpc"
  subnet_name         = "peex1-subnet"
  igw_name            = "peex1-igw"
  route_table_name    = "peex1-route-table"
}

module "secrets" {
  source                = "./modules/secrets"
  passwd_len            = 24
  peex_creds            = "peex-mysql-credentials"
  peex_creds_desc       = "MySQL credentials"
  username              = "admin"
  peex_key_pair_name    = "key-pair"
  peex_key_pair_value   = "peex"
  peex_key_pair_desc    = "Key Pair Name for EC2"
}

module "iam" {
  source                = "./modules/iam"
  role_name             = "peex1-secret-role"
  policy_name           = "peex1-secret-policy"
  secret_arn            = "arn:aws:secretsmanager:eu-west-1:*:secret:mysql-credentials-*"
  instance_profile_name = "peex1-secret-instance-profile"
}

module "ec2_instance" {
  source                 = "./modules/ec2"
  ami_name               = var.ami_name
  vpc_id                 = module.vpc.vpc_id
  subnet_id              = module.vpc.subnet_id
  private_ip             = var.private_ip
  instance_type          = "t2.micro"
  key_pair_name          = "peex"
  iam_instance_profile   = module.iam.instance_profile_name
  tags                   = {
    Name = "peex1-secret-instance"
  }
  user_data = file("${path.module}/assets/get_secret.sh")
}
