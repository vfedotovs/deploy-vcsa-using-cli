# deploy-vcsa-using-cli


# Prerequsites
- [ ] Windows Server 2022 Standard OS - 4GB RAM 60GB storage for disk    
- [ ] VCSA installation ISO image - aprox 10 GB size   
- [ ] DNS server that has A record and reverse record for VC hostname and IP    
- [ ] json template file   
- [ ] Limitation you cannot install VCSA with cli on ESXi host with free license   


# Steps how to install
1. Mount VCSA ISO
2. Copy template json file to C:\
3. on Windows OS, navigate to the vcsa-cli-installer\win32 directory.
4. Run deployment command:
   ```sh
   vcsa-deploy install --accept-eula --acknowledge-ceip C:\deploy_vcsa_template.json
   ```
