resource "aws_instance" "gogs01" {
  connection = {
    user = "ubuntu"
  }

  ami = "${lookup(var.ami_ids, var.aws["region"])}"
  instance_type = "${var.instance_type}"
  key_name = "samin-mb"
  vpc_security_group_ids = ["${aws_security_group.gogs-secgroup.id}"]
  subnet_id = "${aws_subnet.gogs-subnet.id}"

  provisioner "file" {
    source = "scripts"
    destination = "~"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y && sudo apt-get install -y python python-pip python-dev"
    ]
  }

  provisioner "local-exec" {
    command = "echo '[gogs]\n${aws_instance.gogs01.public_ip}' > inventory"
  }

  provisioner "local-exec" {
    command = "ansible-galaxy install --roles-path roles -r roles.txt"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -s -i inventory --ssh-common-args '-o StrictHostKeyChecking=no' playbook.yml"
  }
}
