#AWS web serving infrasturcture as code

#Developer - Swarnamyuran Thiyagarajah BSc (Hons) Information Technology - Special: Computer_Systems_and_Network_Engineering 
#Follow me on: LinkedIn - @swarnamyuran
#              GitHub   - @swarnamyuran

#Configure AWS Provider
#Operational environment is set to run in <us-east-1> region

provider "aws" {
    region = "us-east-1"
    access_key = "<AccessKey>"
    secret_key = "<SecretKey>"
}
