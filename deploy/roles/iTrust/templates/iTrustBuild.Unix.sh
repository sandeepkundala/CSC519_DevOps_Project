#!/bin/bash
cd /
sudo rm -rf iTrust2-v6
sudo git clone https://$GH_USER:$GH_PASS@github.ncsu.edu/engr-csc326-staff/iTrust2-v6.git
cd iTrust2-v6/iTrust2/src/main/java
sudo touch email.properties
sudo touch db.properties
sudo rm db.properties.template
sudo rm email.properties.template
sudo cp /db.properties.j2 /iTrust2-v6/iTrust2/src/main/java/db.properties
sudo cp /email.properties.j2 /iTrust2-v6/iTrust2/src/main/java/email.properties
cd /iTrust2-v6/iTrust2/
