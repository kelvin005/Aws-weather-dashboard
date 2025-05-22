terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.98.0"
    }
  }
}
provider "aws" {
  region = var.region
  
}

module "vpc" {
  source = "./vpc"
}
module "ec2_instance-1" {
  source = "./ec2"
  public_subnet = module.vpc.my_public_subnet_id-A
  security_group = [module.vpc.my_sg_id]
  ami = "ami-04f167a56786e4b09"
  key_name = "weather_app"
  instance_type = "t2.micro"
  tags= {
    Name = "weather-web-server-2"
  }
}

module "ec2_instance-2" {
  source = "./ec2"
  public_subnet = module.vpc.my_public_subnet_id-B
  security_group = [module.vpc.my_sg_id]
  ami = "ami-04f167a56786e4b09"
  key_name = "weather_app"
  instance_type = "t2.micro"
    tags= {
    Name = "weather-web-server-2"
  }
}


module "load_balancer" {
  source = "./load-balancer"
  alb_security_group =  [module.vpc.my_sg_id]
  vpc_id = module.vpc.my_vpc_id
  public_subnet-A = module.vpc.my_public_subnet_id-A
  public_subnet-B = module.vpc.my_public_subnet_id-B
}

