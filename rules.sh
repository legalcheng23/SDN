#!/bin/bash

# ONOS 控制器的地址和認證
CONTROLLER_IP="192.168.1.1"
USER="onos"
PASSWORD="rocks"

# 添加從 h1 到 h2 的流表規則
curl -X POST -H "Content-Type: application/json" -d '{
  "priority": 60000,
  "isPermanent": true,
  "deviceId": "of:0000000000000001",
  "treatment": {
    "instructions": [
      {
        "type": "OUTPUT",
        "port": "2"
      }
    ]
  },
  "selector": {
    "criteria": [
      {
        "type": "ETH_TYPE",
        "ethType": "0x0800"
      },
      {
        "type": "IP_PROTO",
        "protocol": 1
      },
      {
        "type": "IPV4_SRC",
        "ip": "10.0.0.1/32"
      },
      {
        "type": "IPV4_DST",
        "ip": "10.0.0.2/32"
      }
    ]
  }
}' http://$CONTROLLER_IP:8181/onos/v1/flows --user $USER:$PASSWORD

# 添加從 h2 到 h1 的流表規則
curl -X POST -H "Content-Type: application/json" -d '{
  "priority": 60000,
  "isPermanent": true,
  "deviceId": "of:0000000000000002",
  "treatment": {
    "instructions": [
      {
        "type": "OUTPUT",
        "port": "1"
      }
    ]
  },
  "selector": {
    "criteria": [
      {
        "type": "ETH_TYPE",
        "ethType": "0x0800"
      },
      {
        "type": "IP_PROTO",
        "protocol": 1
      },
      {
        "type": "IPV4_SRC",
        "ip": "10.0.0.2/32"
      },
      {
        "type": "IPV4_DST",
        "ip": "10.0.0.1/32"
      }
    ]
  }
}' http://$CONTROLLER_IP:8181/onos/v1/flows --user $USER:$PASSWORD

# 廣播 ARP 請求的流表規則 (h1)
curl -X POST -H "Content-Type: application/json" -d '{
  "priority": 60000,
  "isPermanent": true,
  "deviceId": "of:0000000000000001",
  "treatment": {
    "instructions": [
      {
        "type": "OUTPUT",
        "port": "FLOOD"
      }
    ]
  },
  "selector": {
    "criteria": [
      {
        "type": "ETH_TYPE",
        "ethType": "0x0806"
      }
    ]
  }
}' http://$CONTROLLER_IP:8181/onos/v1/flows --user $USER:$PASSWORD

# 廣播 ARP 請求的流表規則 (h2)
curl -X POST -H "Content-Type: application/json" -d '{
  "priority": 60000,
  "isPermanent": true,
  "deviceId": "of:0000000000000002",
  "treatment": {
    "instructions": [
      {
        "type": "OUTPUT",
        "port": "FLOOD"
      }
    ]
  },
  "selector": {
    "criteria": [
      {
        "type": "ETH_TYPE",
        "ethType": "0x0806"
      }
    ]
  }
}' http://$CONTROLLER_IP:8181/onos/v1/flows --user $USER:$PASSWORD

echo "All flows have been added successfully."
