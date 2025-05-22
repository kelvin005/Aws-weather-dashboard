variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "Key pair name for the EC2 instance"
  type        = string
}

variable "public_subnet" {
  description = "Public subnet ID for the EC2 instance"
  type        = string
}

variable "security_group" {
  description = "Security group ID(s) for the EC2 instance"
  type        = list(string)
}

variable "tags" {
  description = "Tags for the EC2 instance"
  type        = map(string)
}

