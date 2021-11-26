resource "aws_dynamodb_table" "cupper" {
  name = "cupper"
  hash_key = "sessionId"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "sessionId"
    type = "S"
  }
}
