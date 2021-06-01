#AWS web serving infrasturcture as code

#Developer - Swarnamyuran Thiyagarajah BSc (Hons) Information Technology - Special: Computer_Systems_and_Network_Engineering 
#Follow me on: LinkedIn - @swarnamyuran
#              GitHub   - @swarnamyuran

#Security configurations

#Create security group for instances
resource "aws_security_group" "TF_allow_web" {
    name        = "allow_elb_traffic"
    description = "Allow LB inbound traffic"
    vpc_id      = aws_vpc.TF_vpc.id

    #Inbound HTTP
    ingress {
        description      = "HTTP from VPC"
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        security_groups = [aws_security_group.TF_ELB_SG.id]
    }

    #Inbound HTTPS
    ingress {
        description      = "HTTPs from VPC"
        from_port        = 443
        to_port          = 443
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    #Inbound SSH
    ingress {
        description      = "SSH from VPC"
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    #Outbound ANY
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "TF_Allow_Web"
    }
}

#Create security group for Elastic Load Balancer
resource "aws_security_group" "TF_ELB_SG" {
    name        = "allow_web_traffic"
    description = "Allow Web inbound traffic"
    vpc_id      = aws_vpc.TF_vpc.id

    #Inbound HTTP
    ingress {
        description      = "HTTP from VPC"
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        
    }

    #Inbound HTTPS
    ingress {
        description      = "HTTPs from VPC"
        from_port        = 443
        to_port          = 443
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    #Inbound SSH
    ingress {
        description      = "SSH from VPC"
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    #Outbound ANY
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "TF_ELB_SG"
    }
}