#!/bin/bash
if [ -z ${1+x} ]; then echo "usage: $0 <cve id>" && exit 1; fi

CVE_ID="$1"
CVE_LOWERCASE=$(echo $CVE_ID | tr '[:upper:]' '[:lower:]')
CVE_UPPERCASE=$(echo $CVE_ID | tr '[:lower:]' '[:upper:]')
CVE=$(echo $CVE_UPPERCASE | sed -e 's/-//g')

echo "Adding files for $CVE_ID"

WASP_FILE="main.wasp"
CLIENT_FILE="src/client/vulnerability/${CVE}Page.tsx"
SERVER_FILE="src/server/vulnerability/${CVE}.ts"
SHARED_FILE="src/shared/vulnerability/${CVE}.ts"

cat template/client.tsx | envsubst > $CLIENT_FILE
cat template/server.tsx | envsubst > $SERVER_FILE
cat template/shared.tsx | envsubst > $SHARED_FILE

cat template/cve.wasp | envsubst >> $WASP_FILE