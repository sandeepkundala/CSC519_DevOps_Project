#!/bin/bash
cd /home/vagrant
sudo rm -rf iTrust2-v6
sudo git clone https://$GH_USER:$GH_PASS@github.ncsu.edu/engr-csc326-staff/iTrust2-v6.git
cd iTrust2-v6/iTrust2/src/main/java
sudo touch email.properties
sudo touch db.properties
sudo rm db.properties.template
sudo rm email.properties.template
sudo cp /home/vagrant/db.properties.j2 /home/vagrant/iTrust2-v6/iTrust2/src/main/java/db.properties
sudo cp /home/vagrant/email.properties.j2 /home/vagrant/iTrust2-v6/iTrust2/src/main/java/email.properties
cd /home/vagrant/iTrust2-v6/iTrust2/
sudo mvn -f pom-data.xml process-test-classes
sudo mvn clean test verify org.apache.maven.plugins:maven-checkstyle-plugin:3.1.0:checkstyle