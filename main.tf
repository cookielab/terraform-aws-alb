resource "aws_security_group" "main" {
  name = "${var.name_prefix}alb"
  description = "Main Application LoadBalancer"

  vpc_id = var.vpc
}

resource "aws_security_group_rule" "main_egress" {
  security_group_id = aws_security_group.main.id

  type        = "egress"
  protocol    = "all"
  from_port   = 0
  to_port     = 65535
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "main_icmp" {
  security_group_id = aws_security_group.main.id

  type        = "ingress"
  protocol    = "icmp"
  from_port   = 0
  to_port     = 65535
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "main_http" {
  security_group_id = aws_security_group.main.id

  type        = "ingress"
  protocol    = "tcp"
  from_port   = 80
  to_port     = 80
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "main_https" {
  security_group_id = aws_security_group.main.id

  type        = "ingress"
  protocol    = "tcp"
  from_port   = 443
  to_port     = 443
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_lb" "main" {
  name               = "${var.name_prefix}${var.name}"
  load_balancer_type = "application"
  internal           = false

  subnets = var.subnets
  security_groups = concat([aws_security_group.main.id], var.additional_security_groups)

}

resource "aws_lb_listener" "main_http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "main_http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.default_certificate


  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404 - NotFound"
      status_code  = "404"
    }
  }
}
