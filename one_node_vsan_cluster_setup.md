
VSAN 9 OSA notes 

Prerequsites:
- ESXI installed with min 2 NICs and one cache and once cpacity disk in addition of 50 GB boot device


```sh

esxcli vsan cluster get

esxcli vsan cluster new

esxcli vsan storage tag add -t capacityFlash -d mpx.vmhba5:C0:T0:L0

vsan storage add  -s mpx.vmhba3:C0:T0:L0 -d mpx.vmhba5:C0:T0:L0

Fix deploy VM error on single  VSAN node cluster due to lack of fault domains
Verify current default SP rules 
esxcli vsan policy getdefault

Use RVC or esxcli to set default storage policy with force provisioning enabled or FTT0
vsan.set_cluster_default_policy Cluster_ID_in_previous_listing “((\”hostFailuresToTolerate\” i1) (\”forceProvisioning\” i1))”.

```
