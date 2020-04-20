## CHECKPOINT - MILESTONE 3
#### Tasks Implemented in Checkpoint of Milestone 3

**Provision:**
- Created wrapper to execute command `pipeline prod up`.
- Provisioned AWS EC2 instances using one of the teammate's account and private key.
- Configured those instances to be monitored and shown in `https://<monitor_ip>:8080`

**Deploy:**
- Created wrapper to execute command `pipeline deploy <app> -i inventory.ini`
- Created checkbox ansible role to deploy checkbox.io application on AWS instance
- Created iTrust ansible role to deploy Itrust application on AWS instance

**Canary:**
- Created wrapper to execute command `pipeline canary <blue> <green>`
- Programmed logic to provision 3 VMs in local machine.


#### Future work for milestone 3

- Monitor the blue and green VMs.
- Generate load to the proxy server by requesting the `/preview` service. 
- For the first 5 minutes, send the load to the blue instance, collect health metrics.
- Next, send traffic to the green instance for 5 minutes, collect health metrics.
- Perform canary analysis by doing statistical comparision.
