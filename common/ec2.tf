
resource "aws_instance" "bastion" {
  ami = "${var.bastion.image_id}"
  instance_type = "t2.micro"
  key_name = "${var.bastion.key_name}"
  subnet_id =  aws_subnet.your-sub-pub1.id
  associate_public_ip_address = "true"
  vpc_security_group_ids = [
    aws_security_group.bastion.id
  ]
  tags = {
    Name = "bastion"
  }
}
