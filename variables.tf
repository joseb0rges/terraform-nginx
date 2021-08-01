# Default Region
variable "region" {
  description = "AWS Region"
  default = "us-east-1"
}

# Caminho para a public key SSH
# Edite para a chave pública do seu usuário
variable "key_path" {
  description = "Public key path"
  default = "~/.ssh/id_rsa.pub"
}

# Tipo da AMI que será utilizada para as EC2
variable "ami" {
  description = "AMI"
  default = "ubuntu/images/hvm-ssd/ubuntu-disco-19.04-amd64-server-*" // ubuntu
}

# Classe da instância que será utilizada
variable "instance_type" {
  description = "EC2 instance type"
  default = "t2.micro"
}


