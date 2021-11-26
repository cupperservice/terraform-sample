resource "aws_dynamodb_table" "cupper" {
  name = "${var.session.table_name}"
  hash_key = "sessionId"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "sessionId"
    type = "S"
  }
}
