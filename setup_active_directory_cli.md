
How to with screenhots
https://vxworld.co.uk/2025/01/22/vmware-gpu-homelab-part-4-building-a-windows-domain-controller-and-dns-server/
- [ ] Install/Deploy Windows server VM
- [ ] Configure (server name) reboot required
- [ ] Configure ststic IP  
- [ ] Install the the Active Directory Binaries and Management Tools using the command below (elevated PowerShell )
```sh
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
```
- [ ] Promote the Server to a Domain Controller using the following script. Replace the DomainName value with your domain.
```sh
Import-Module ADDSDeployment
Install-ADDSForest -DomainName "lab.vxworld.co.uk" -InstallDNS
```
- [ ] The Forward Lookup Zone for the domain should have been automatically created by the AD installer.
- [ ] To create the Reverse Lookup Zone. You can either follow the steps below or run the following PowerShell Command
```sh
Add-DnsServerPrimaryZone -NetworkID "192.168.1.0/24" -ReplicationScope Domain -DynamicUpdate Secure
```
- [ ] To create the DNS A and PRT records for each of the two hosts in the cluster. Note: substitute the Name, ZoneName and IPv4Address values
```sh
Add-DnsServerResourceRecordA -Name "gpu-esxi-01" -ZoneName "lab.vxworld.co.uk" -IPv4Address "192.168.1.101" -CreatePtr
Add-DnsServerResourceRecordA -Name "gpu-esxi-02" -ZoneName "lab.vxworld.co.uk" -IPv4Address "192.168.1.102" -CreatePtr
```
- [ ] Test DNS lookup is working
```sh
for forward lookup
nslookup google.com

for reverse lookup
nslookup 8.8.8.8

```
