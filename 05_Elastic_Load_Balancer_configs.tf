#AWS web serving infrasturcture as code

#Developer - Swarnamyuran Thiyagarajah BSc (Hons) Information Technology - Special: Computer_Systems_and_Network_Engineering 
#Follow me on: LinkedIn - @swarnamyuran
#              GitHub   - @swarnamyuran

#ELB configuration

#Configure Elastic Load Balancer (Classic Load Balancer)
resource "aws_elb" "my-elb" {
    name               = "my-elb"
    subnets = [aws_subnet.TF_subnet_1a.id, aws_subnet.TF_subnet_1b.id]
    security_groups = [aws_security_group.TF_ELB_SG.id]

    listener {
        instance_port     = 80
        instance_protocol = "http"
        lb_port           = 80
        lb_protocol       = "http"
    }

    health_check {
        healthy_threshold   = 10
        unhealthy_threshold = 2
        timeout             = 5
        target              = "HTTP:80/"
        interval            = 10
    }

    instances                   = [aws_instance.myFirst_TF-server.id, aws_instance.mySecond_TF-server.id]
    cross_zone_load_balancing   = true
    idle_timeout                = 400
    connection_draining         = true
    connection_draining_timeout = 400

    tags = {
        Name = "my-elb"
    }
}

#Terraform console output
output "Load_Balancer_DNS" {
    value = aws_elb.my-elb.dns_name
}