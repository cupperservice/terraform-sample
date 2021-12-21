data "template_file" "app-svr-definition" {
  template = file("${path.module}/ecs_task_definitions/app-svr.json")
  vars = {
    region               = var.region
    db_endpoint          = "${aws_db_instance.cupper-db.endpoint}"
    db_name              = var.database.name
    db_username          = var.database.username
    db_password          = var.database.password
    session_table_name   = var.session.table_name
  }
}

resource "aws_ecs_task_definition" "app-svr" {
  depends_on = [
  #   aws_ecr_repository.entry-cms-batch,
  #   aws_cloudwatch_log_group.entry-cms-batch
  ]

  container_definitions    = data.template_file.app-svr-definition.rendered
  family                   = "app-svr"
  network_mode             = "awsvpc"
  execution_role_arn       = "${var.ecs.exec_role}"
  task_role_arn            = "${var.ecs.task_role}"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048
}

resource "aws_ecs_cluster" "app-cluster" {
  name = "your-app-cluster"
}

resource "aws_ecs_service" "app-service" {
  name = "your-app-service"

  depends_on = ["aws_lb_listener_rule.tg2"]

  # 当該ECSサービスを配置するECSクラスターの指定
  cluster = "${aws_ecs_cluster.app-cluster.name}"

  # データプレーンとしてFargateを使用する
  launch_type = "FARGATE"

  # ECSタスクの起動数を定義
  desired_count = "1"

  # 起動するECSタスクのタスク定義
  task_definition = "${aws_ecs_task_definition.app-svr.arn}"

  # ECSタスクへ設定するネットワークの設定
  network_configuration {
    # タスクの起動を許可するサブネット
    subnets = [
      "${aws_subnet.your-sub-pri1.id}",
      "${aws_subnet.your-sub-pri1.id}"
    ]
    # タスクに紐付けるセキュリティグループ
    security_groups = ["${aws_security_group.app.id}"]
    assign_public_ip = true
  }

  # ECSタスクの起動後に紐付けるELBターゲットグループ
  load_balancer {
    target_group_arn = "${aws_alb_target_group.alb.arn}"
    container_name   = "app-svr"
    container_port   = "8080"
  }
}