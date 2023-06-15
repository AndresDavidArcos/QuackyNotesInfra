resource "aws_instance" "production_quackynoteapp" {

  ami                    = var.base_ami_id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.production_rules.id]
  key_name               = aws_key_pair.production_key.key_name
  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get -y update
    sudo apt-get -y install curl
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key 7EA0A9C3F273FCD8
    sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
    apt-cache policy docker-ce
    sudo apt install -y docker-ce
    sudo apt install docker-compose -y
  EOF
  tags = {
    "Name" = "production_quackynoteapp"
  }
}

output "production_dns" {
  value = aws_instance.production_quackynoteapp.public_dns
}
