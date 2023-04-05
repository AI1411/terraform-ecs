resource "aws_security_group" "alb" {
  name        = "${local.app}-alb"
  description = "Allow inbound traffic from the internet to the ALB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow HTTP from the internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.app}-alb"
  }
}

resource "aws_security_group" "ecs" {
  name        = "${local.app}-ecs"
  description = "Allow inbound traffic from the ALB to the ECS instances"
  vpc_id      = module.vpc.vpc_id

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.app}-ecs"
  }
}

resource "aws_security_group_rule" "ecs_from_alb" {
  description              = "Allow inbound traffic from the ALB to the ECS instances"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ecs.id
  source_security_group_id = aws_security_group.alb.id
}