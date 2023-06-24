resource "aws_security_group" "web_server_sg" {
  name        = "web-server-sg"
  description = "Security group for SSH and HTTP access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db_server_sg" {
  name        = "database-server-sg"
  description = "Security group for MySQL"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  ami           = "ami-02bf24eb1dd9ca3dc"
  instance_type = var.instance_type
  subnet_id     = "subnet-0c0f46c3eca6b2961"  
  key_name      = "vedad-varupa-web-server-key"
  tags = {
    Name  = "task-12-web-server-tf"
    Stage = var.stage_name
  }

  vpc_security_group_ids = [
    aws_security_group.web_server_sg.id,
    aws_security_group.db_server_sg.id,
  ]
}

resource "aws_instance" "db_server" {
  ami           = "ami-02bf24eb1dd9ca3dc"
  instance_type = var.instance_type
  subnet_id     = "subnet-036f6c5d45adb87f1"
  key_name      = "vedad-varupa-web-server-key"
  tags = {
    Name  = "task-12-db-server-tf"
    Stage = var.stage_name
  }

  vpc_security_group_ids = [
    aws_security_group.web_server_sg.id,
    aws_security_group.db_server_sg.id,
  ]
}