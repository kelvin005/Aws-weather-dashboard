resource "aws_launch_template" "weather_app_template" {
  name_prefix   = "weather-app-launch-template"
  image_id      = "ami-04f167a56786e4b09"
  instance_type = "t2.micro"

  network_interfaces {
    associate_public_ip_address = true
    security_groups   = var.alb_security_group
  }
  user_data = base64encode(file("${path.module}/auto-scale-script.sh"))
  }



resource "aws_lb_target_group" "weather_app_target_group" {
  name     = "weather-app-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-299"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_autoscaling_group" "weather_app_auto_scaling_group" {
  desired_capacity     = 2
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier  = [var.public_subnet-A, var.public_subnet-B]
  target_group_arns    = [aws_lb_target_group.weather_app_target_group.arn]
  health_check_type    = "ELB"

  launch_template {
    id      = aws_launch_template.weather_app_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "autoscaled-instance"
    propagate_at_launch = true
  }
}

resource "aws_lb" "weather_app_loadbalancer" {
  name               = "weather-app-loadbalancer"
  load_balancer_type = "application"
  subnets            = [var.public_subnet-A, var.public_subnet-B]
  security_groups    = var.alb_security_group
}

resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.weather_app_loadbalancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.weather_app_target_group.arn
  }
}
