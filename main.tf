provider "aws" {
  region     = "eu-west-3"
  access_key = "AKIATCKAOE3DKSG4OYSI"
  secret_key = "5Q/eLkqTBAu6S2UkBlQM4jKtT0uyTk89OnKeUMo5"
}


resource "aws_instance" "example" {
  ami           = "ami-00c71bd4d220aa22a"
  instance_type = "t2.micro"
}