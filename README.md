# TEAM - 06
## Members
| | Name | ID |
| :---: | :---: | :---: |
|1| Rajshree Jain | rjain27 |
|2| Jaydip Gabani| jgabani |
|3| Sandeep Kundala | skundal |

## Milestone 1 - Pipleline > Build

### Tasks
- Automatically configure jenkins server
- Automatically configure a build environment
- Create build job


### Discussion points
| Date | Notes |
| :---: | :---: |
| 02-14-2020 | **Division of task:** All the Milestone 1a tasks are divided among team members to start parallely. |
| 02-19-2020 | **Discussed task completion and checkpoint 1 submission:** Discussed the completion of our tasks, submitted work till today and discussed the further steps |
| 02-26-2020 | **Discussed progress and future work:** Discussed the progress of project and tasks to be completed for the final submission of Milestone 1 |
| 03-01-2020 | **Discussed completion ofMilestone 1:** Disscussed the completion of the milestone and blockers such as implementation of pm2 |
| 03-02-2020 | **Discussed regarding refactoring:** Discussed the places where refactoring has to be done such has better task names, converting shell commands to appropriate ansible-modules (if any) |


### Report
#### Architecture
![](resources/checkbox_io.png)

#### Technologies Used
- NodeJS: As a wrapper to execute custom commands like pipeline setup and pipeline build.
- Bash: As a wrapper for to execute playbooks and running shell scripts.
- Virtual Box: Provisioning of VMs with required configuration.
- Ansible: Configuration of Jenkins-srv to install necessary packages for Jenkins, build environment and build job.
- Jenkins: Perform build job using the set configuration.

#### Challenges Faced:
- Faced issues while provisioning VMs since the IP address for jenkins-srv doesn't get the desired IP
- Execution of groovy script to configure Jenkins
- Build-jobs failing due to mongodb port mismatch
- Build-jobs failing due to quotes(") in the environment variables
- Getting logs from the jenkins regarding the latest executed build

#### Contribution:
- Setting NodeJS and Bash wrapper to execute commands: SANDEEP KUNDALA
- Configuring Jenkins: RAJSHREE JAIN
- Configuring build environment: JAYDIP GABANI
- Build job configuration: RAJSHREE JAIN, JAYDIP GABANI, SANDEEP KUNDALA

#### Setup
``` 
git clone https://github.com/sandeepkundala/CSC519_DevOps_Project.git devops6
cd devops6
dos2unix cm/server-init.sh
dos2unix cm/run-ansible.sh
npm install
npm link

# to provision server and configure build environment:
pipeline setup

# to trigger build job:
pipeline build checkbox.io
```
*Note:*
- *In slower machines,  there has been issues where IP address of Jenkins-srv is not assigned during provisioning of VMs (pipeline setup). In such cases, it is advised to run the command (pipeline setup) again* 
- *It is also observed that, while provisioning VM, in ansible-srv or jenkins-srv, there is dpkg-lock error. In such cases, shut down the VM and run bakerx run \<vm-name\> bionic --ip \<ip_addr\>*
### Screencast
The link of the screencast is [here](https://drive.google.com/open?id=1YQkI-mi75f6QiPOK6zF41MpbfVinCOTS)


### Checkpoint reports
Read [CHECKPOINT.md](CHECKPOINT.md)
