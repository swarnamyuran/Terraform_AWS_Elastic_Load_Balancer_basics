#AWS web serving infrasturcture as code

#Developer - Swarnamyuran Thiyagarajah BSc (Hons) Information Technology - Special: Computer_Systems_and_Network_Engineering 
#Follow me on: LinkedIn - @swarnamyuran
#              GitHub   - @swarnamyuran

#Linux environment configuration

#Install and configure Apache web server on AmazonLinux
#Deployed on /us-east-1a/
resource "aws_instance" "myFirst_TF-server" {
    ami           = "ami-0d5eff06f840b45e9"
    instance_type = "t2.micro"
    availability_zone = "us-east-1a"
    key_name = "aws_tutorial"
    user_data = <<-EOF
        #!/bin/bash
        yum update -y
        yum upgrade -y
        yum install -y httpd.x86_64
        systemctl start httpd.service
        systemctl enable httpd.service
        echo "Hello this is terraform made Amazon_Linux server from $(hostname -f)" > /var/www/html/index.html
        EOF

    network_interface {
        device_index = 0
        network_interface_id = aws_network_interface.TF_NIC_AMZN_LX.id
    }

  tags = {
    Name = "TF_AmazonLinux_web"
  }
}

#Install and configure Apache web server on Ubuntu
#Deployed on /us-east-1b/
resource "aws_instance" "mySecond_TF-server" {
    ami           = "ami-09e67e426f25ce0d7"
    instance_type = "t2.micro"
    availability_zone = "us-east-1b"
    key_name = "aws_tutorial"
    user_data = <<-EOF
        #!/bin/bash
        sudo apt-get update -y
        sudo apt-get install -y apache2
        sudo systemctl start apache2
        echo "Hello this is terraform made Ubuntu server from $(hostname -f)" > /var/www/html/index.html
        EOF

    network_interface {
        device_index = 0
        network_interface_id = aws_network_interface.TF_NIC_UBUNTU.id
    }

  tags = {
    Name = "TF_Ubuntu_web"
  }
}