variable "alb_security_group" {
  description = "Security group ID for the ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "public_subnet-A" {
    description = "Public subnet A ID"
    type       = string
}
variable "public_subnet-B" {
    description = "Public subnet A ID"
    type = string
}