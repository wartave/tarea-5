 #Bootstrap Jenkins installation and start  
 <<-EOF
 #!/bin/bash #specifies the interpreter
sudo yum update -y  # updates the package list and upgrades installed packages on the system
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo  #downloads the Jenkins repository configuration file and saves it to /etc/yum.repos.d/jenkins.repo
sudo wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add  #imports the GPG key for the Jenkins repository. This key is used to verify the authenticity of the Jenkins packages
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo yum upgrade -y #  upgrades packages again, which might be necessary to ensure that any new dependencies required by Jenkins are installed
sudo apt install openjdk-11-jdk -y
sudo yum install jenkins -y  #installs Jenkins itself
sudo systemctl enable jenkins  #enables the Jenkins service to start automatically at boot time
sudo systemctl start jenkins   #starts the Jenkins service immediately
sudo ufw allow 8080 #activar firwall
sudo ufw allow OpenSSH
sudo ufw enable
sudo apt-get install git -y
sudo apt-get install docker.io -y
sudo systemctl start docker
sudo usermod -aG docker root
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo chmod 666 /var/run/docker.sock
EOF

  user_data_replace_on_change = true