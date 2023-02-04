#creating VPC
resource "aws_vpc" "altschool_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "${var.env_prefix}-vpc"
  }
}



# add all the subnets to the existing VPC using cidr block with availability zone and tags
resource "aws_subnet" "altschool_subnet" {
  for_each          = var.subnet_block
  vpc_id            = aws_vpc.altschool_vpc.id
  cidr_block        = each.value["cidr"]
  availability_zone = each.value["az"]

  tags = {
    Name       = "${each.key}"
    Enviroment = each.value["name"]
  }
}


#add internet gateway
resource "aws_internet_gateway" "altschool_igw" {
  vpc_id = aws_vpc.altschool_vpc.id

  tags = {
    Name = "${var.env_prefix}-igw"
  }
}




#use default route table created with VPC and add route to internet gateway
resource "aws_default_route_table" "altschool_route_table" {
  default_route_table_id = aws_vpc.altschool_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.altschool_igw.id
  }

  tags = {
    Name = "${var.env_prefix}-rtb"
  }
}

#creating security group
resource "aws_default_security_group" "altschool_sg" {
  vpc_id = aws_vpc.altschool_vpc.id

  dynamic "ingress" {
    for_each = var.inbound_ports
    content {
      description = "Allow poer 80 and 22 inbound traffic"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }


  egress {
    description     = "Allow all inbound traffic"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name = "${var.env_prefix}-sg"
  }
}



#creating load balancer
resource "aws_lb" "altschool_elb" {
  internal        = false
  security_groups = [aws_default_security_group.altschool_sg.id]
  subnets         = local.subnets
}

#load balancer target group
resource "aws_lb_target_group" "altschool_elb_target_group" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.altschool_vpc.id

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
  }
}


resource "aws_lb_listener" "altshool_elb_listener" {
  load_balancer_arn = aws_lb.altschool_elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.altschool_elb_target_group.arn
  }
}


resource "aws_lb_target_group_attachment" "altschool_elb_target_group_attachment" {
  count = length(local.instance_ids)

  target_group_arn = aws_lb_target_group.altschool_elb_target_group.arn
  target_id        = local.instance_ids[count.index]
  port             = 80
}