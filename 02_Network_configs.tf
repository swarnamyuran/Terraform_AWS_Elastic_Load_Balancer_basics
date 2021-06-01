#AWS web serving infrasturcture as code

#Developer - Swarnamyuran Thiyagarajah BSc (Hons) Information Technology - Special: Computer_Systems_and_Network_Engineering 
#Follow me on: LinkedIn - @swarnamyuran
#              GitHub   - @swarnamyuran

#Network Configurations

#Configure custom VPC
resource "aws_vpc" "TF_vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "TF_vpc"
    }
}

#Configure internet gateway
resource "aws_internet_gateway" "TF_gw" {
    vpc_id = aws_vpc.TF_vpc.id

    tags = {
        Name = "TF_gw"
    }
}

#Configure custom route table
resource "aws_route_table" "TF-rte-tble" {
    vpc_id = aws_vpc.TF_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.TF_gw.id
    }

      route {
        ipv6_cidr_block        = "::/0"
        gateway_id = aws_internet_gateway.TF_gw.id
    }

    tags = {
        Name = "TF-route"
    }
}

#Configure subnet for us-east-1a
resource "aws_subnet" "TF_subnet_1a" {
    vpc_id = aws_vpc.TF_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"

    tags = {
        ame = "TF_subnet"
    }
}

#Configure subnet for us-east-1b
resource "aws_subnet" "TF_subnet_1b" {
    vpc_id = aws_vpc.TF_vpc.id
    cidr_block = "10.0.10.0/24"
    availability_zone = "us-east-1b"

    tags = {
        ame = "TF_subnet"
    }
}

#Configure route table with subnet 1a
resource "aws_route_table_association" "TF_sub_ass_1a" {
    subnet_id      = aws_subnet.TF_subnet_1a.id
    route_table_id = aws_route_table.TF-rte-tble.id
}

#Configure route table with subnet 1b
resource "aws_route_table_association" "TF_sub_ass_1b" {
    subnet_id      = aws_subnet.TF_subnet_1b.id
    route_table_id = aws_route_table.TF-rte-tble.id
}

#Configure network interface for AmazonLinux
resource "aws_network_interface" "TF_NIC_AMZN_LX" {
    subnet_id       = aws_subnet.TF_subnet_1a.id
    private_ips     = ["10.0.1.50"]
    security_groups = [aws_security_group.TF_allow_web.id]

    tags = {
        Name = "TF_NIC_AMZN_LX"
    }
}

#Configure network interface for Ubuntu
resource "aws_network_interface" "TF_NIC_UBUNTU" {
    subnet_id       = aws_subnet.TF_subnet_1b.id
    private_ips     = ["10.0.10.51"]
    security_groups = [aws_security_group.TF_allow_web.id]

    tags = {
        Name = "TF_NIC_UBUNTU"
    }
}

#Create AWS Elastic IP for AmazonLinux
resource "aws_eip" "TF_EIP_1" {
    vpc                       = true
    network_interface         = aws_network_interface.TF_NIC_AMZN_LX.id
    associate_with_private_ip = "10.0.1.50"
    depends_on = [aws_internet_gateway.TF_gw]
}

#Create AWS Elastic IP for Ubuntu
resource "aws_eip" "TF_EIP_2" {
    vpc                       = true
    network_interface         = aws_network_interface.TF_NIC_UBUNTU.id
    associate_with_private_ip = "10.0.10.51"
    depends_on = [aws_internet_gateway.TF_gw]
}