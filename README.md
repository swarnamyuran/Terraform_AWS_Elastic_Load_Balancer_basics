#AWS web serving infrasturcture as code

#Developer - Swarnamyuran Thiyagarajah BSc (Hons) Information Technology - Special: Computer_Systems_and_Network_Engineering 
#Follow me on: [LinkedIn](https://www.linkedin.com/in/swarnamyuran/)
#              [GitHub](https://github.com/swarnamyuran)

# Terraform_AWS_Elastic_Load_Balancer_basics
Configuring Elastic Load Balancer for web servers through Terraform infrastructure as code. 

This repository contains the files to setup and configure Load balancing environment in Amazon Web Services. Terraform HCL is used to automate the processes of network, 
security and linux instances configurations. The setup of environment is deploying 2 apache2 webservers on Amazon_Linux and Ubuntu t2.micro type instances with custom VPC
and subnets and balancing the HTTP requests from clients through Classic Load Balancer also known as Elastic Load Balancer. Seperate security groups are configured to
Linux instances and ELB to let the instances accessed by the clients only through ELB.

Useful commands for this Terraform files

/ terraform init / - This command is used to initialize a working directory containing Terraform configuration files. This is the first command that should be run after writing a new
                     Terraform configuration or cloning an existing one from version control. It is safe to run this command multiple times.
                     
/ terraform plan / - This command creates an execution plan. By default, creating a plan consists of:
                     *  Reading the current state of any already-existing remote objects to make sure that the Terraform state is up-to-date.
                     *  Comparing the current configuration to the prior state and noting any differences.
                     *  Proposing a set of change actions that should, if applied, make the remote objects match the configuration.
                     
/ terraform plan / - This command executes the actions proposed in a Terraform plan.

Useful links:   [Terraform Documentations](https://www.terraform.io/docs/)
                [AWS Documnetations](https://docs.aws.amazon.com)
