docker-test-env
===============

1. Run initial_script.sh to complete preinstallation tasks
==========================================================

2. Create docker swarm and Start containers
===========================================

3. Access running jenkins container url
=======================================
Access  http://<ip_addr>:80


4. Follow processes for below Jenkins pipeline
==============================================

Install Plugins 
---------------
copy artifact
deploy to container
github
copy artifacts
build pipeline

Info
----
Jenkins war location	: /usr/share/jenkins/jenkins.war 
Packages needed		: apt install git maven openjdk-8-jdk/stable mvn-3.3.9
maven project repo	: https://github.com/jleetutorial/maven-project.git
maven command to build 	: -Dmaven.test.skip=true clean package checkstyle:checkstyle
maven commandline   	: mvn -Dmaven.test.skip=true clean package

Tomcat manager details
----------------------
#<!-- <role rolename="manager-gui"/> -->
#<!-- <user username="tomcat" password="tomcat" roles="manager-gui"/> -->


Pipeline Project
=============================
Step 1	- Mention Git SCM : https://github.com/jleetutorial/maven-project.git
	- Add build action "invoke to level maven" with "-Dmaven.test.skip=true clean package"
	- Add post build action "Archive artifacts" : **/*.war
	- Add post build action "build other project" and give project name which will be created in step 2

Step 2	- check install plugin "copy artifact" and deploy to container plugin
	- Create new freestyle project 
	- Add Build step "Copy artifacts from another project" with project name
	- Add post build actions "deploy to container" with credentials

Step 3  - Add "build pipeline" plugin
	- Click on "+" to add "build pipeline view"
	- Mention initial job to which starts pipeline
	- Will view pipeline

Step 4  - Add "checkstyle" to parallel pipeline
	- Add git repo in source code management https://github.com/jleetutorial/maven-project.git
	- Add build action "invoke to level maven" with "checkstyle:checkstyle"
	- Go to other project which will trigger this project add the post build action to trigger this project
   
