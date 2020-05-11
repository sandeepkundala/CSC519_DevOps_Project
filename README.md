# TEAM - 06
## Members
| | Name | ID |
| :---: | :---: | :---: |
|1| Rajshree Jain | rjain27 |
|2| Jaydip Gabani| jgabani |
|3| Sandeep Kundala | skundal |

## Milestone 2 - Pipleline > Test+Analysis

### Discussion points
| Date | Notes |
| :---: | :---: |
| 03-05-2020 | **Division of task:** All the Milestone 2a tasks are divided among team members to start parallely. |
| 03-12-2020 | **Discussed task progress:** Discussed the progress of our tasks, blockers and future steps |
| 03-17-2020 | **Discussed completion of Checkpoint and future work:** Completed 60% of the project including nodejs wrapper, itrust environment configuratin, itrust build configuration and static analysis of checkbox.io |
| 03-23-2020 | **Discussed task progress:** Discussed the progress of fuzzing, blockers and future steps |
| 04-04-2020 | **Discussed completion of Milestone 2:** Performed end to end manual testing of the project and completed screencast |


### Report
#### Architecture
![](resources/m2.png)

#### Tasks
- Automatically configure a build environment and build job for a Java application (iTrust).
  - [Build envirorment for iTrust](cm/roles/iTrust_envi/tasks/main.yml)
  - [Build job for iTrust](cm/roles/create_jobs/templates/iTrust_jenkins_jobs.yml)

- Implement a test suite analysis for detecting useful tests.
  - Implemented [fuzzer](Fuzzer/fuzzer.js) to 
    - swap "<" with ">"
    - swap "==" with "!="
    - swap 0 with 1
    - swap "true" with "false"
  - Performed analysis to detect [useful tests](Fuzzer/FS.js).
  - The result for one such run is [here](results/192.168.33.20/home/vagrant/Fuzzer/final_result_100.txt)

- Implement a static analysis for detecting code smells.
  - Implemented [static analysis](Complexity/analysis.js) on checkbox.io which checks for the below conditions and fail the build if any of the below conditions are satisfied.
    - Long method: Detect long methods (>100 LOC).
    - Message Chains: Detect message chains (for .) (>10 chains)
    - MaxNestingDepth: Count the max number of if statements in a function (>5)
    
#### Technologies Used
- NodeJS: As a wrapper to execute custom commands like pipeline setup, pipeline build and fuzzing.
- Bash: As a wrapper for to execute playbooks and running shell scripts.
- Virtual Box: Provisioning of VMs with required configuration.
- Ansible: Configuration of Jenkins-srv to install necessary packages for Jenkins, build environment, build job and running maven tests.
- Jenkins: Perform build job using the set configuration.

#### Challenges Faced:
- The build job for jenkins was affected due to less memory allocated for Jenkins-srv.
- Fuzzing the files (generics were getting impacted).
- Each maven test was taking 15-30 min.

#### Contribution:
- Setting NodeJS wrapper to execute useful-test command: SANDEEP KUNDALA
- Configuring build environment for iTrust: SANDEEP KUNDALA, RAJSHREE JAIN
- Configuring jenkins build job for iTrust: RAJSHREE JAIN
- Performing static analysis on checkbox.io: JAYDIP GABANI
- Creating fuzzer: RAJSHREE JAIN, JAYDIP GABANI, SANDEEP KUNDALA
- Performing test prioratization analysis: JAYDIP GABANI, RAJSHREE JAIN

#### Setup
``` 
git clone https://github.com/sandeepkundala/CSC519_DevOps_Project.git devops6
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
```
*Note:*
- *In slower machines,  there has been issues where IP address of Jenkins-srv is not assigned during provisioning of VMs (pipeline setup). In such cases, it is advised to run the command (pipeline setup) again* 
- *It is also observed that, while provisioning VM, in ansible-srv or jenkins-srv, there is dpkg-lock error. In such cases, shut down the VM and run bakerx run \<vm-name\> bionic --ip \<ip_addr\>*


### Screencast
The link of the screencast is [here](https://drive.google.com/open?id=1O39hjqkJGnAzt_sn3DD1DS3RbWT5DzHn)



### Checkpoint reports
#### Milestone 2 - Test + Analysis
Read [CHECKPOINT.md](CHECKPOINT_MILESTONE2.md)

#### Milestone 1 - Build
Read [CHECKPOINT.md](CHECKPOINT.md)
