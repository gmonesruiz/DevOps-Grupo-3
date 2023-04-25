# Nos conectamos a AWS con el provider y profile credentials creado previamente // configured aws provider with profile credentials
provider "aws" {
  region    = "us-east-1"
  profile   = "terraform-user"
}


# Se crea una vpc default en caso se no tener, si existe una cambiar los parametros // create jenkins vpc if one does not exit
resource "aws_default_vpc" "default_vpc" {

  tags    = {
    Name  = "jenkins vpc"
  }
}


# Viabilitizone y la region // use data source to get all avalablility zones in region
data "aws_availability_zones" "available_zones" {}


# Se crea la subnet si no tienes una, en caso de tener cambiar los parametros // create jenkins subnet if one does not exit.
#Este valor de available_zones.names[0] indica que tomara la primera availablezone / si se coloca 1, toma la segunda, si coloco 3 toma la 2
resource "aws_default_subnet" "default_az1" {
  availability_zone = data.aws_availability_zones.available_zones.names[0]

  tags   = {
    Name = "jenkins subnet"
  }
}


# Se crea el security group para la instancia ec2 // create security group for the ec2 instance
resource "aws_security_group" "ec2_security_group" {
  name        = "ec2 security group"
  description = "allow access on ports 8080 and 22"
  vpc_id      = aws_default_vpc.default_vpc.id

  # Se habilita el puerto a jenkins // allow access on port 8080 Jenkins port
  ingress {
    description      = "http proxy access"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # Se habilita la conexion por ssh // allow access on port 22 ssh conexion
  ingress {
    description      = "ssh access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "jenkins server security group"
  }
}


# Se traen los datos de la instancia// use data source to get a registered amazon linux 2 ami
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


# Se crea la instancia en este casp una t2.medium // launch the ec2 instance and install website
resource "aws_instance" "ec2_instance" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t3.medium"
# instance_type          = "t3.medium"
  subnet_id              = aws_default_subnet.default_az1.id
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]
  key_name               = "ec2_key"
  # user_data            = file("install_jenkins.sh") para el usuario y contraseña de jenkins

  tags = {
    Name = "jenkins server"
  }
}


# Esto crea un bloque de recurso vacio se llama connection // an empty resource block 
# Para conectarte a ec2 por ssh con el usuario y el key.epm y la ip publica
resource "null_resource" "name" {

  # Se usa el .pem y el usuario  para conectarse a la instancia // ssh into the ec2 instance 
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/Downloads/ec2_key.pem")
    host        = aws_instance.ec2_instance.public_ip
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


# Imprime la url de jenkins para conectarnos // print the url of the jenkins server / 
output "website_url" {
  value     = join ("", ["http://", aws_instance.ec2_instance.public_dns, ":", "8080"])
}


## Tener en cuenta que generamos un bloque vacio para conectarnos a la instancia de AWS, con la finalizad de no ejecutar comando para conectarnos y obtener la password de Jenkins
## Por lo cual por el promt o CLI se debe mostrar la contraseña con que haremos el login inicial

## Para ejecutar .\terraform apply
## Para destruir la instancia .\terraform destroy