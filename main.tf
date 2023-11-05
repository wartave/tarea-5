terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.28.1"
    }
  }
}

provider "digitalocean" {
  token = file("${path.module}/token.txt")
}


resource "digitalocean_droplet" "jenkins_server" {
  image    = "ubuntu-20-04-x64"
  name     = "jenkins-server"
  region   = "nyc3"
  size     = "s-1vcpu-1gb"
  ssh_keys = [file("${path.module}/ssh.txt")]

   
 connection {
    type     = "ssh"
     user     = "root"
    private_key = file("~/.ssh/id_rsa")
    host     = self.ipv4_address  
  }
 provisioner "remote-exec" {
   
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y git default-jdk",
      "sudo wget -q -O - https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo apt-key add -",
      "echo deb http://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list",
      "sudo apt-get update -y",
      "sudo apt-get install -y jenkins",
      "sudo apt install openjdk-11-jdk -y",
    ]
  }
}