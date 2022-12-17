resource "aws_instance" "foo" {
  ami         = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = "testkey"    # create your own key and upload it in your local machine
  vpc_security_group_ids = [aws_security_group.demo-ssh.id]  
  

}

/* git remote add origin https://github.com/Devops-pro-group/terraform-projects.git
git branch -M main
git push -u origin main */