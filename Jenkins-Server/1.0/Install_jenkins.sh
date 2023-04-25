#!/bin/bash
sudo yum update –y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
    sudo yum upgrade -y 
    sudo amazon-linux-extras install java-openjdk11 -y
    sudo yum install jenkins -y
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
    sudo systemctl status jenkins
    sudo yum install git -y
    #sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo amazon-linux-extras install docker -y 
    sudo systemctl start docker
    sudo usermod -a -G docker ec2-user
    sudo yum-config-manager \    --add-repo \    https://download.docker.com/linux/rhel/docker-ce.repo
    sudo systemctl enable docker
    sudo usermod -aG docker jenkins
    sudo chmod 666 /var/run/docker.sock
    sudo yum install -y gcc-c++ make 
    curl -sL https://rpm.nodesource.com/setup_19.x | sudo -E bash - 
    sudo yum install -y nodejs 
    ## OJO con la instalacion de nodejs
    sudo yum install nmp 
    #OJO nmp
    sudo cat /var/lib/jenkins/secrets/initialAdminPassword
    

