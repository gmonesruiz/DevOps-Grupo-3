resource "aws_instance" "ec2_instance" {
  ami                    = var.ami_id
 # count                  = var.number_of_instances
  subnet_id              = aws_subnet.subnet_public.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg_22.id]
  key_name               = aws_key_pair.ec2key.key_name
}

resource "aws_key_pair" "ec2key" {
  key_name   = "publicKey"
  public_key = file(var.public_key_path)
}
