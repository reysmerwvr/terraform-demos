# app

data "template_file" "nodejsapp-task-definition-template" {
  template = file("templates/app.json.tpl")
  vars = {
    REPOSITORY_URL = replace(aws_ecr_repository.nodejsapp.repository_url, "https://", "")
    APP_VERSION    = var.MYAPP_VERSION
  }
}

resource "aws_ecs_task_definition" "nodejsapp-task-definition" {
  family                = "nodejsapp"
  container_definitions = data.template_file.nodejsapp-task-definition-template.rendered
}

resource "aws_ecs_service" "nodejsapp-service" {
  count           = var.MYAPP_SERVICE_ENABLE
  name            = "nodejsapp"
  cluster         = aws_ecs_cluster.example-cluster.id
  task_definition = aws_ecs_task_definition.nodejsapp-task-definition.arn
  desired_count   = 1
  iam_role        = aws_iam_role.ecs-service-role.arn
  depends_on      = [aws_iam_policy_attachment.ecs-service-attach1]

  load_balancer {
    elb_name       = aws_elb.nodejsapp-elb.name
    container_name = "nodejsapp"
    container_port = 3000
  }
  lifecycle {
    ignore_changes = [task_definition]
  }
}

# load balancer
resource "aws_elb" "nodejsapp-elb" {
  name = "nodejsapp-elb"

  listener {
    instance_port     = 3000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 30
    target              = "HTTP:3000/"
    interval            = 60
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  subnets         = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
  security_groups = [aws_security_group.nodejsapp-elb-securitygroup.id]

  tags = {
    Name = "nodejsapp-elb"
  }
}

