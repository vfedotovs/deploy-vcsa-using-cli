# deploy-vcsa-using-cli


# Prerequsites
- [ ] Windows Server 2022 Standard OS - 4GB RAM 60GB storage for disk    
- [ ] VCSA installation ISO image - aprox 13 GB size   
- [ ] DNS server that has A record and reverse record for VC hostname and IP    
- [ ] deploy_vcsa_template.json template file with valid settings 
- [ ] Limitation you cannot install VCSA with cli on ESXi host with free license   


# Steps how to install
1. Copy template json file to C:\
2. In Windows OS, navigate to the vcsa-cli-installer\win32 directory.
3. Run unattended deployment command (Installs VCSA VM and configures SSO domain):
   ```sh
   vcsa-deploy install --accept-eula --acknowledge-ceip C:\deploy_vcsa_template.json
   ```
Example of sucessfull deployment
```sh
VCSA Deployment is still running
==========VCSA Deployment Progress Report==========
Task: Install required RPMs for the appliance.(SUCCEEDED 100/100)       
- Task has completedsuccessfully.         
Task: Run firstboot scripts.(SUCCEEDED 100/100) - Task has completed successfully.
Successfully completed VCSA deployment.  

VCSA Deployment Start Time: 2025-07-03T15:41:12.950Z VCSA Deployment End Time: 2025-07-03T15:52:04.383Z
 [SUCCEEDED] Successfully executed Task 'MonitorDeploymentTask: Monitoring
Deployment' in TaskFlow 'deploy_vcsa_template' at 15:52:32
Monitoring VCSA Deploy task completed
== [START] Start executing Task: Join active domain if necessary at 15:52:33 ==
Domain join task not applicable, skipping task
 [SUCCEEDED] Successfully executed Task 'Running deployment: Domain Join' in
TaskFlow 'deploy_vcsa_template' at 15:52:33
 [START] Start executing Task: Provide the login information about new
appliance. at 15:52:33
    Appliance Name: VCSA-90
    System Name: vc90.lab.local
    System IP: 192.168.1.90
    Log in as: Administrator@vsphere.local
 [SUCCEEDED] Successfully executed Task 'ApplianceLoginSummaryTask: Provide
appliance login information.' in TaskFlow 'deploy_vcsa_template' at 15:52:33
=================================== 15:52:33 ===================================
Result and Log File Information...
WorkFlow log directory:
C:\Users\ADMINI~1\AppData\Local\Temp\2\vcsaCliInstaller-2025-07-03-15-39-qnas2p5o\workflow_1751557144117
```
