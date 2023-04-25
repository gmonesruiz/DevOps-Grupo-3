
resource "aws_instance" "jenkins" {
  ec2_associate_public_ip_address = "true"
  ami             = "ami-05b457b541faec0ca"
  instance_type   = "t3.medium"
  security_groups = [aws_security_group.jenkins-sg.name]
  key_name        = "Budgie-Paris"



}
