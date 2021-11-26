resource "aws_cloudwatch_log_group" "app-svr" {
  name              = "/app-svr/task-definition"
  retention_in_days = 400
}
