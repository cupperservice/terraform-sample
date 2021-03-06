terraform {
  required_version = "= 1.1.2"
}

module "common" {
  source = "../common"
  region = "ap-northeast-1"
  az1 = "ap-northeast-1a"
  az2 = "ap-northeast-1c"
  bastion = {
    image_id = "ami-0404778e217f54308"
    key_name = "cupper"
  }
  database = {
    name = "mall"
    username = "kawashima"
    password = "kazuhisa"
  }
  session = {
    table_name = "cupper-Session"
    key_name = "sessionId"
  }
  ecs = {
    exec_role = ""
    task_role = ""
  }
}
