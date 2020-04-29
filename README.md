# TEAM - 06
## Members
| | Name | ID |
| :---: | :---: | :---: |
|1| Rajshree Jain | rjain27 |
|2| Jaydip Gabani| jgabani |
|3| Sandeep Kundala | skundal |

## Milestone 3 - Pipleline > Deploy

### Discussion points
| Date | Notes |
| :---: | :---: |
| 04-10-2020 | **Division of task:** All the Milestone 3 tasks are divided among team members to focus. |
| 04-15-2020 | **Discussed task progress:** Discussed the progress. Completed enhancements of M2, nodejs command wrappers, provisioning and monitoring of ec2 instances in AWS. |
| 04-21-2020 | **Discussed completion of Checkpoint and future work:** Completed deployment of applications in AWS ec2 instances. |
| 04-24-2020 | **Discussed task progress:** Fixed checkpoint errors. Provisioned VMs for canary task |
| 04-28-2020 | **Discussed completion of Milestone 3:** Completed canary analysis using Mann-Whitney U Test. Performed end to end manual testing of the project and completed screencast |

### Report
#### Architecture
![](https://github.ncsu.edu/cscdevops-spring2020/DEVOPS-06/blob/master/resources/m3.png)

#### Tasks
- Provision cloud instances and monitoring control plane.
  - Get AWS credentials: Follow the instruction to create IAM User and configuring AWS in the local machine: https://blog.ipswitch.com/how-to-create-an-ec2-instance-with-python
  - Edit AWS Configuration:
    - [Decrypt and edit vars file to input AWS Configurations](https://github.ncsu.edu/cscdevops-spring2020/DEVOPS-06/blob/master/cm/vars/vars.yml)
    - [Replace the key here](https://github.ncsu.edu/cscdevops-spring2020/DEVOPS-06/blob/master/provision/roles/provision_envi/templates/ec2-KP-devops06.pem) with your personal AWS private key.(here the key is encrypted)
  - [setup jenkins server for AWS EC2 provisioning environment](https://github.ncsu.edu/cscdevops-spring2020/DEVOPS-06/blob/master/provision/provision.yml)
  - [Provision ec2 instances in AWS](https://github.ncsu.edu/cscdevops-spring2020/DEVOPS-06/blob/master/provision/roles/provision_envi/templates/create_aws_vm.py)
  - [Setup Monitor VM in AWS](https://github.ncsu.edu/cscdevops-spring2020/DEVOPS-06/blob/master/provision/monitor.yml)
  - [Setup iTrust VM in AWS](https://github.ncsu.edu/cscdevops-spring2020/DEVOPS-06/blob/master/provision/iTrust.yml)
  - [Setup checkbox.io VM in AWS](https://github.ncsu.edu/cscdevops-spring2020/DEVOPS-06/blob/master/provision/checkbox.yml)
  - [Monitoring VM with dashboard](https://github.ncsu.edu/cscdevops-spring2020/DEVOPS-06/tree/master/provision/roles/monitor_setup/templates/dashboard)
  - [iTrust monitoring and checkbox monitoring](https://github.ncsu.edu/cscdevops-spring2020/DEVOPS-06/tree/master/provision/roles/webserver_setup/templates/agent)
  
- Deploy checkbox.io and iTrust.
  
  
- Canary Analysis.
  - [Completed canary analysis task](https://github.ncsu.edu/cscdevops-spring2020/DEVOPS-06/blob/master/commands/canary.js) by provisioning VMs, running proxy, performing canary analysis and deleting the VMs)
  - Implemented [proxy and canary analysis](https://github.ncsu.edu/cscdevops-spring2020/DEVOPS-06/blob/master/canary/roles/proxy/templates/proxy.js) on the blue green server.
    
#### Technologies Used
- NodeJS: 
  - As a wrapper to execute custom commands like pipeline setup, pipeline prod up, pipeline deploy, and pipeline canary.
  - For proxy controller.
  - For canary analysis
- Bash: As a wrapper for to execute playbooks and running shell scripts.
- Python: Create EC2 instances in AWS
- Virtual Box: Provisioning of VMs with required configuration.
- Ansible: Configuration of Jenkins-srv to install necessary packages for Jenkins, build environment, build job and running maven tests.
- Jenkins: Perform build job using the set configuration.
- Redis: To store the monitoring metrics.

#### Challenges Faced:
- We faced some issue as we had wrongly installed python2 on our servers which was leading to conflicts while we were running our ansible scripts. Then we realised that it would be a good idea to use only the pre installed python3 version and set the python interpreter in ansible to python3
- Writing logic for performing monitoring accurately.
- Execution of Canary analysis took time because we had to understand the flow of the process and also check how the automation should be implemented.
- While the execution of the "pipeline canary master broken" command we observed the blue and green servers were not comming up due to which we were not able to ssh into them. So we used the wait_for_connection module of ansible that helped.
- Getting metrics from backend servers to proxy servers.

#### Contribution:
- Setting NodeJS wrapper to execute prod up, deploy and canary command: SANDEEP KUNDALA, RAJSHREE JAIN
- Provision VMs in AWS environment: SANDEEP KUNDALA, RAJSHREE JAIN
- Perform monitoring of itrust VM and checkbox VM via monitor vm using dashboard: SANDEEP KUNDALA
- Configure and deploy iTrust application in AWS ec2 instance: JAYDIP GABANI
- Configure and deploy checkbox application in AWS ec2 instance: JAYDIP GABANI
- Configure environment for canary analysis by provisioning VMs and configuring proxy to the 2 backend servers: RAJSHREE JAIN
- Perform Canary Analysis: RAJSHREE JAIN, SANDEEP KUNDALA

#### Setup
``` 
git clone https://github.ncsu.edu/cscdevops-spring2020/DEVOPS-06.git devops6
cd devops6
dos2unix cm/server-init.sh
dos2unix cm/run-ansible.sh
npm install
npm link

# to provision server and configure build environment:
pipeline setup --gh-user <NCSU GITHUB USERNAME> --gh-pass <NCSU GITHUB PASSWORD>

# to trigger build job for iTrust:
pipeline build iTrust

# Initiate analysis of test suite for iTrust to run `-c` numbers of times.
pipeline useful-tests -c <number>

# to trigger build job for checkbox.io:
pipeline build checkbox.io

# to provision VM in AWS:
pipeline prod up

# to deploy applications into the AWS VM:
pipeline deploy <app> -i <inventory.ini>

# to perform canary analysis:
pipeline canary <blueServer> <greenServer>
```
*Note:*
- *In slower machines,  there has been issues where IP address of Jenkins-srv is not assigned during provisioning of VMs (pipeline setup). In such cases, it is advised to run the command (pipeline setup) again* 
- *It is also observed that, while provisioning VM, in ansible-srv or jenkins-srv, there is dpkg-lock error. In such cases, shut down the VM and run bakerx run \<vm-name\> bionic --ip \<ip_addr\>*


### Screencast
The link of the screencast is [here](https://drive.google.com/open?id=1O39hjqkJGnAzt_sn3DD1DS3RbWT5DzHn)

### Issues

All issues pertaining to Milestone 3 is [here](https://github.ncsu.edu/cscdevops-spring2020/DEVOPS-06/issues?utf8=%E2%9C%93&q=is%3Aissue+label%3A%22Milestone+3%22+)

### Kanban board

The kanban project board is [here](https://github.ncsu.edu/cscdevops-spring2020/DEVOPS-06/projects/3)


### Checkpoint reports
#### Milestone 3 - 
Read [CHECKPOINT.md](https://github.ncsu.edu/cscdevops-spring2020/DEVOPS-06/blob/master/CHECKPOINT_M3.md)

#### Milestone 2 - Test + Analysis
Read [CHECKPOINT.md](https://github.ncsu.edu/cscdevops-spring2020/DEVOPS-06/blob/master/CHECKPOINT_MILESTONE2.md)

#### Milestone 1 - Build
Read [CHECKPOINT.md](https://github.ncsu.edu/cscdevops-spring2020/DEVOPS-06/blob/master/CHECKPOINT.md)
