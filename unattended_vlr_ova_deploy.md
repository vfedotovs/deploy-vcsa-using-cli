ovftool --acceptAllEulas --noSSLVerify --skipManifestCheck \
--name="VLSR-Appliance-01" \
--datastore="Your-Datastore" \
--network="VM-Network" \
--deploymentOption="standard" \
--prop:vami.hostname="vlsr-01.domain.com" \
--prop:vami.ip0.VLSR-Appliance="192.168.1.50" \
--prop:vami.netmask0.VLSR-Appliance="255.255.255.0" \
--prop:vami.gateway.VLSR-Appliance="192.168.1.1" \
--prop:vami.DNS.VLSR-Appliance="192.168.1.10" \
"VMware-Live-Recovery-Appliance-9.0.5.ova" \
"vi://administrator@vsphere.local:password@vcenter-fqdn/Datacenter/host/Cluster"


Postdeployment REST api call tasks

Phase 1: Register Appliance to vCenterBefore you can pair sites, the appliance must be "attached" to its local vCenter. This is done via the Appliance Management API (typically on port 5480).1. Authenticate to the ApplianceBash# Get an authentication token using the 'admin' credentials set during OVA deployment
curl -X POST "https://<appliance-ip>:5480/api/v1/session" \
     -u "admin:<password>" \
     -k -i
2. Configure vCenter Connection (PSC Registration)This step mimics the "Reconfigure" button in the UI.Bashcurl -X POST "https://<appliance-ip>:5480/api/v1/configure" \
     -H "Content-Type: application/json" \
     -d '{
       "psc_hostname": "vcenter-01.example.com",
       "psc_port": 443,
       "sso_admin_user": "administrator@vsphere.local",
       "sso_admin_password": "vcenter-password",
       "site_name": "Protected-Site-A",
       "extension_id": "com.vmware.vcDr"
     }' -k
Phase 2: Establish Site PairingOnce both appliances (Protected and Recovery) are registered to their respective vCenters, you use the SRM REST API Gateway (typically on port 443) to link them.1. Login to the SRM APIBashcurl -X POST "https://<appliance-ip>/api/rest/srm/v1/session" \
     -u "administrator@vsphere.local:<password>" \
     -k
Note: This returns an x-dr-session token in the header. You must include this in subsequent calls.2. Create the Site PairYou must call this on the Protected Site appliance, pointing to the Recovery Site vCenter/SRM.Bashcurl -X POST "https://<protected-srm-ip>/api/rest/srm/v1/pairings" \
     -H "x-dr-session: <your-session-id>" \
     -H "Content-Type: application/json" \
     -d '{
       "remote_vc_address": "vcenter-02.example.com",
       "remote_vc_port": 443,
       "remote_sso_admin_user": "administrator@vsphere.local",
       "remote_sso_admin_password": "recovery-vcenter-password"
     }' -k
Summary of EndpointsTaskAPI EndpointPortAppliance Auth/api/v1/session5480vCenter Registration/api/v1/configure5480SRM Operations Auth/api/rest/srm/v1/session443Site Pairing/api/rest/srm/v1/pairings443
