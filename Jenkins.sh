#!/bin/bash
# Author: Benjamin
# Date: February 2017
# This is an automaded Jenkins installation script.  
# _____________________________Jenkins Automated Installation _________________________

echo "Welcome to Jenkins Automated Installation"
echo "Please wait ..."
sleep 1

# Enabling the Jenkins repository
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
if [ $? -eq 0 ]
then
sudo sed -i 's/gpgcheck=1/gpgcheck=0/g' /etc/yum.repos.d/jenkins.repo
else
sudo yum install wget -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo sed -i 's/gpgcheck=1/gpgcheck=0/g' /etc/yum.repos.d/jenkins.repo
fi 
clear


sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
if [ $? -eq 0 ]
then 
echo "Installation in process. Please wait ..."
else
echo "Installation failed! Please read error message"
exit 4
fi

sudo yum upgrade -y
echo "Installation in process. Please wait ..."


# Add required dependencies for the jenkins package - Java installation process
sudo yum install -y java-11-openjdk
if [ $? -eq 0 ]
then 
echo "Java Installation in process. Please wait ..."
else
echo "Installation failed! Please read error message"
exit 7
fi

# Install Jenkins package
sudo yum install -y jenkins
if [ $? -eq 0 ]
then 
echo "Jenkins Installation in process. Please wait ..."
else
echo "Installation failed! Please read error message"
exit 6
fi

# Enable and start Jenkins daemon
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
if [ $? -eq 0 ]
then
echo "Jenkins successfully installed and enabled"
else
echo "Jenkins installation failed. Please read the error message"
exit 8
fi
clear

sudo cat /var/lib/jenkins/secrets/initialAdminPassword
echo "Access Jenkins using http://localhost:8080 (or whichever port you configured)"
echo "Copy the automatically-generated alphanumeric password above and paste it into the Administrator password field to unlock Jenkins."
sleep 20

