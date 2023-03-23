
resource "aws_instance" "jenkins" {
  ami             = "ami-05b457b541faec0ca"
  instance_type   = "t2.medium"
  security_groups = [aws_security_group.jenkins-sg.name]
  key_name        = "Budgie-Paris"
  
  user_data = <<-EOF
    #!/bin/bash
    set -ex
    sudo apt-get update -y && sudo apt install docker -y
    sudo service docker start
    sudo usermod -a -G docker terraform-course
    sudo curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo apt install openjdk-11-jdk -y
    wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
    sudo sh -c "echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list"
    sudo apt-get update && sudo apt-get install jenkins -y
    usermod -aG docker jenkins
    sudo systemctl start jenkins
    sudo systemctl enable jenkins
    sudo echo "jenkins ALL=(ALL) NOPASSWD:ALL" | /etc/sudoers.d/jenkins
  EOF
  
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "terraform-course"
    private_key = file("/home/jose/Desktop/credentials/budgie-paris.pem")
  }
  tags = {
    "Name" = "Jenkins"
  }
}
