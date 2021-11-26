terraform {
  required_version = "= 0.15.5"
}

module "common" {
  source = "../common"
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
  }
}
