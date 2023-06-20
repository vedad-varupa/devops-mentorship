# TASK-12 Packer - > Ansible -> CloudFormation / Terrafrom

IAM User 1 ce svoje resurse da kreira unutar eu-central-1 regiona.
IAM User 2 ce svoje resurse da kreira unutar us-east-1 regiona.
IAM User 3 ce svoje resurse da kreira unutar eu-west-1 regiona

For task 12 you need to do following:

 ** [PACKER] - Create Custom AMI image from Amazon Linux 3 AMI image where you will have needed yum repos installed and enabled to install nginx web server and mysql database.

 ** [IaC - CloudFormation] Using an AMI image from step 1 create 2 new EC2 instances called task-12-web-server-cf and task-12-db-server-cf. For those instances create appropriate security groups and open needed ports. Please try to follow best practices for security groups. You can put your resources inside default VPC and public subnets.

 ** [IaC - Terraform] Using an AMI image from step 1 create 2 new EC2 instances called task-12-web-server-tf and task-12-db-server-tf. For those instances create appropriate security groups and open needed ports. Please try to follow best practices for security groups. You can put your resources inside default VPC and public subnets.

 ** [Ansible] By using ansible provisioner install nginx web server on task-12-web-server-cf and task-12-web-server-tf instances. By using ansilbe provisioner install mysql database on task-12-db-server-cf and task-12-db-server-tf instances.

 You need to ensure that once when nginx is instaled that it is enabled and started. Same goes for mysql database. Also your nginx web server instances needs to have index.html file with content Hello from nginx web server created using CloudFormation and Ansible Hello from nginx web server created using Terrafrom and Ansible.


 - [x] [PACKER] - Create Custom AMI image from Amazon Linux 3 AMI image where you will have needed yum repos installed and enabled to install nginx web server and mysql database.

  ![Screenshots-1](week-14/packer/Screenshot-1.png)
  ![Screenshots-2](week-14/packer/Screenshot-2.png)
  ![Screenshots-3](week-14/packer/Screenshot-3.png)
  ![Screenshots-4](week-14/packer/Screenshot-4.png)
  

  - [x] [IaC - CloudFormation] Using an AMI image from step 1 create 2 new EC2 instances called task-12-web-server-cf and task-12-db-server-cf. For those instances create appropriate security groups and open needed ports. Please try to follow best practices for security groups. You can put your resources inside default VPC and public subnets.

  ![Screenshots-5](week-14/packer/Screenshot-5.png)
  ![Screenshots-6](week-14/packer/Screenshot-6.png)
  ![Screenshots-7](week-14/packer/Screenshot-7.png)
  ![Screenshots-8](week-14/packer/Screenshot-8.png)
  ![Screenshots-9](week-14/packer/Screenshot-9.png)
  ![Screenshots-10](week-14/packer/Screenshot-10.png)
  ![Screenshots-11](week-14/packer/Screenshot-11.png)
  ![Screenshots-12](week-14/packer/Screenshot-12.png)
  ![Screenshots-13](week-14/packer/Screenshot-13.png)

  - [x] [IaC - Terraform] Using an AMI image from step 1 create 2 new EC2 instances called task-12-web-server-tf and task-12-db-server-tf. For those instances create appropriate security groups and open needed ports. Please try to follow best practices for security groups. You can put your resources inside default VPC and public subnets.

  ![Screenshots-14](week-14/terraform/Screenshot-14.png)
  ![Screenshots-15](week-14/terraform/Screenshot-15.png)
  ![Screenshots-16](week-14/terraform/Screenshot-16.png)
  ![Screenshots-17](week-14/terraform/Screenshot-17.png)
  ![Screenshots-18](week-14/terraform/Screenshot-18.png)
  ![Screenshots-19](week-14/terraform/Screenshot-19.png)
  ![Screenshots-20](week-14/terraform/Screenshot-20.png)
  ![Screenshots-21](week-14/terraform/Screenshot-21.png)

  - [x] [Ansible] By using ansible provisioner install nginx web server on task-12-web-server-cf and task-12-web-server-tf instances. By using ansilbe provisioner install mysql database on task-12-db-server-cf and task-12-db-server-tf instances.

  ![Screenshots-22](week-14/ansible/Screenshot-22.png)
  ![Screenshots-23](week-14/ansible/Screenshot-23.png)
  ![Screenshots-24](week-14/ansible/Screenshot-24.png)
  ![Screenshots-25](week-14/ansible/Screenshot-25.png)
  ![Screenshots-26](week-14/ansible/Screenshot-26.png)
  ![Screenshots-27](week-14/ansible/Screenshot-27.png)
  ![Screenshots-28](week-14/ansible/Screenshot-28.png)
  ![Screenshots-29](week-14/ansible/Screenshot-29.png)
  ![Screenshots-30](week-14/ansible/Screenshot-30.png)






