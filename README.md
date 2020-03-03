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


### Setup
``` 
git clone https://github.ncsu.edu/cscdevops-spring2020/DEVOPS-06.git devops6
cd devops6
dos2unix cm/server-init.sh
dos2unix cm/run-ansible.sh

# to provision server and configure build environment:
pipeline setup

# to trigger build job:
pipeline build checkbox.io
```

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
![](https://github.ncsu.edu/cscdevops-spring2020/DEVOPS-06/blob/master/resources/checkbox_io.png)

#### Technologies Used
- NodeJS
- Virtual Box
- Ansible
- Jenkins

#### Challenges Faced:
- Faced issues while provisioning VMs since the IP address for jenkins-srv doesn't get the desired IP
- Execution of groovy script to configure Jenkins
- Build-jobs failing due to mongodb port mismatch
- Getting logs from the jenkins regarding the latest executed build

### Contribution:
- Setting NodeJS wrapper to execute commands: SANDEEP KUNDALA
- Configuring Jenkins: RAJSHREE JAIN
- Configuring build environment: JAYDIP GABANI
- Build job configuration: RAJSHREE JAIN, JAYDIP GABANI, SANDEEP KUNDALA

Read [checkpoint1.md](https://github.ncsu.edu/cscdevops-spring2020/DEVOPS-06/blob/master/checkpoint1.md)
Read [checkpoint2.md](https://github.ncsu.edu/cscdevops-spring2020/DEVOPS-06/blob/master/checkpoint2.md)
