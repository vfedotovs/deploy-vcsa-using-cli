#!/bin/bash

# Configuration
LSTOOL_PATH="/usr/lib/vmware-lookupsvc/tools"
DIR_CLI_PATH="/usr/lib/vmware-vmafd/bin"
SSO_USER="administrator@vsphere.local"

echo "--------------------------------------------------------"
echo "vCenter 8.x SRM Registration Cleanup Tool"
echo "--------------------------------------------------------"

# 1. Fetch SRM registrations from Lookup Service
echo "[*] Scanning Lookup Service for SRM registrations..."
cd $LSTOOL_PATH || exit

# Extracting Service IDs and URLs for display
REGISTRATIONS=$(./lstool.py list --url http://localhost:7090/lookupservice/sdk --no-check-cert --ep-type com.vmware.dr.vcDr 2>/dev/null)

if [ -z "$REGISTRATIONS" ]; then
    echo "[!] No SRM registrations found."
    exit 0
fi

echo "Found the following SRM Endpoints:"
echo "$REGISTRATIONS" | grep -E "Service ID|vmomi URL|Owner ID"
echo "--------------------------------------------------------"

# 2. Prompt for the Stale Service ID
read -p "Enter the Service ID you wish to UNREGISTER: " STALE_ID
read -p "Enter the Owner ID (Solution User) to DELETE from dir-cli: " STALE_OWNER

if [ -z "$STALE_ID" ] || [ -z "$STALE_OWNER" ]; then
    echo "[!] Error: Service ID and Owner ID cannot be empty."
    exit 1
fi

# 3. Get SSO Password
read -s -p "Enter password for $SSO_USER: " SSO_PASS
echo ""

# 4. Execution - Unregister from Lookup Service
echo "[*] Unregistering Service ID: $STALE_ID..."
./lstool.py unregister --url http://localhost:7090/lookupservice/sdk --id "$STALE_ID" --user "$SSO_USER" --password "$SSO_PASS" --no-check-cert

# 5. Execution - Delete Solution User
echo "[*] Deleting Solution User: $STALE_OWNER..."
cd $DIR_CLI_PATH || exit
./dir-cli service delete --name "$STALE_OWNER" --login "$SSO_USER" --password "$SSO_PASS"

echo "--------------------------------------------------------"
echo "[+] Cleanup process complete."
echo "--------------------------------------------------------"
