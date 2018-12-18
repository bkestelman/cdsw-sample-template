#!/bin/bash

# Detect server from config.ini
SERVER_HOST=$(perl -ne 'print if s/server_host=//' /etc/cloudera-scm-agent/config.ini)
echo "Server Host: $SERVER_HOST"
# Get cluster name from CM API (TODO: check API version)
CLUSTER_NAME=$(curl -u admin:admin "${SERVER_HOST}:7180/api/v19/clusters" 2> /dev/null | perl -ne 'print if s/.*"name" : "(.*)".*/\1/')
echo "Cluster Name: $CLUSTER_NAME"

# Run appropriate script
case "${CLUSTER_NAME}" in
        "Cluster 1")
                echo "Run Cluster 1 script"
                ;;
        "MCC Dev")
                echo "Run MCC Dev script"
                ;;
        "MCC Prod")
                echo "Run MCC Prod script"
                ;;
        "SCC Dev")
                echo "Run SCC Dev script"
                ;;
        "SCC Prod")
                echo "Run SCC Prod script"
                ;;
        *)
                echo "Invalid cluster name"
esac
