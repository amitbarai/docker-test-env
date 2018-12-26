#!/bin/bash

#####################################################
findos=`lsb_release -i >/dev/null 2>&1; echo $?`
if [ "${findos}" -ne "0" ]
then
  myos=`cat /etc/os-release | grep ^ID | grep -v ID_LIKE | awk -F'"' '{print $2}'`
else
  myos=`([ -f /etc/redhat-release ] && cat /etc/redhat-release || cat /proc/version_signature  ) | awk  '{gsub (/[ \t]+/, ""); print substr($1,0,6); }'| tr 'A-Z' 'a-z'`
fi
#####################################################

alias ll='ls -l'
alias ro="sudo -i"
#mkdir -p /app/{git,ansible,tomcat,docker/{jenkins/data,tomcat-prod/data,tomcat-dev/data},apache,backup.`date +%Y%m%d`}


docker_practice_ubuntu() {
                        apt-get remove docker docker-engine docker.io
                        apt-get -y install \
                        apt-transport-https \
                        ca-certificates \
                        curl \
                        software-properties-common
                        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
						sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
                        apt-get -y update && apt-get -y install docker-ce docker-compose gnupg2 pass
                        systemctl start docker
#                       mkdir -p /app/{docker/{jenkins/data,tomcat-prod/data,tomcat-dev/data,testing},composetest,backup.`date +%Y%m%d`} 
						mkdir -p /app/docker/jenkins/data && cd /app/docker/jenkins && wget https://updates.jenkins-ci.org/download/war/2.150.1/jenkins.war
}
lxc_practice_ubuntu() {
						apt -y install lxc lxc-templates sshpass
						systemctl start lxc.service
						lxc-create -n web1 -t ubuntu
						lxc-create -n web2 -t ubuntu
						lxc-create -n web3 -t ubuntu
						lxc-start -n web1 -d
						lxc-start -n web2 -d
						lxc-start -n web3 -d
						lxc-ls -f | awk -F' ' '{print $5,$1}' | sed 's/,//g' | grep -v IPV4 >> /etc/hosts
						ssh-keygen -t rsa
						sshpass -p ubuntu ssh-copy-id ubuntu@`lxc-ls -f | awk -F' ' '{print $1}'`
						#export auth=`cat /root/.ssh/id_rsa.pub` && sshpass -p ubuntu ssh ubuntu@web2 "sudo mkdir /root/.ssh/" && echo $auth >> /root/.ssh/authorized_keys
}

git_practice_ubuntu() {
						apt-get install git
						}
case $myos in 
				ubuntu) docker_practice_ubuntu
					git_practice_ubuntu;;
				
				     *)  echo "os not supported"
					exit;;
esac 
