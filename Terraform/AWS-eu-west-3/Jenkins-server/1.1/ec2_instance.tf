# EC2 instance
resource "aws_instance" "ec2_instance" {
  ami = var.ami_id
  # count                  = var.number_of_instances
  subnet_id              = aws_subnet.subnet_public.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
  key_name               = aws_key_pair.ec2key.key_name
}

resource "aws_key_pair" "ec2key" {
  key_name   = "publicKey"
  public_key = file(var.public_key_path)
}


# Esto crea un bloque de recurso vacio se llama connection // an empty resource block 
# Para conectarte a ec2 por ssh con el usuario y el key.epm y la ip publica
resource "null_resource" "name" {

  # Se usa el .pem y el usuario  para conectarse a la instancia // ssh into the ec2 instance 
  connection {
    type       = "ssh"
    user       = "ubuntu"
    host       = aws_instance.ec2_instance.public_ip
  }

  # Copia el bash de jenkins en la instancia de AWS en el TMP // copy the install_jenkins.sh file from your computer to the ec2 instance  
  provisioner "file" {
    source      = "install_jenkins.sh"
    destination = "/tmp/install_jenkins.sh"
  }

  # Le otorga permisos al bash de jenkins y lo ejecuta, instando jenkins en la instancia de AWS // set permissions and run the install_jenkins.sh file / para ejecutar el .sh
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/install_jenkins.sh",
      "sh /tmp/install_jenkins.sh",
    ]
  }

  # Se espera a que se cree // wait for ec2 to be created
  depends_on = [aws_instance.ec2_instance]
}

