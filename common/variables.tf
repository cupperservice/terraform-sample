variable "region" {}
variable "az1" {}
variable "az2" {}
variable "bastion" {
  type = map(any)

  default = {
    image_id = ""
    key_name = ""
  }
}

variable "database" {
  type = map(any)

  default = {
    name = ""
    username = ""
    password = ""
  }
}

variable "session" {
  type = map(any)

  default = {
    table_name = ""
    key_name = ""
  }
}

variable "ecs" {
  type = map(any)
  
  default = {
    exec_role = ""
    task_role = ""
  }
}
