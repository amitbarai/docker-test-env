# docker-test-env
docker-test-env
======================
docker stack deploy --compose-file test-docker-compose.yml stackdemo
docker container exec -it stackdemo_myjenkins.1.l3e1wyg50hbca6126r4rqxngb /bin/bash

Plugins 
==========
copy artifact
deploy to container
github
copy artifacts
build pipeline

==========================================
Jenkins war location	: /usr/share/jenkins/jenkins.war 
Packages needed			: apt install git maven openjdk-8-jdk/stable mvn-3.3.9
maven project repo		: https://github.com/jleetutorial/maven-project.git
maven command to build 	: mvn -Dmaven.test.skip=true clean package checkstyle:checkstyle

<role rolename="manager-gui"/>
<user username="tomcat" password="tomcat" roles="manager-gui"/>


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

Step 3 - Add "build pipeline" plugin
	   - Click on "+" to add "build pipeline view"
	   - Mention initial job to which starts pipeline
	   - Will view pipeline

Step 4 - Add "checkstyle" to parallel pipeline
	   - Add git repo in source code management https://github.com/jleetutorial/maven-project.git
	   - Add build action "invoke to level maven" with "checkstyle:checkstyle"
	   - Go to other project which will trigger this project add the post build action to trigger this project
	   
	   
		
		
