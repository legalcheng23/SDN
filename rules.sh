#!/bin/bash

# ONOS 控制器的地址和認證
ONOS_CONTROLLER_IP="172.17.0.5"
ONOS_USER="onos"
ONOS_PASS="rocks"

# 設置流表規則

# 1. 允許來自 h1 的流量轉發到 h2
curl --user $ONOS_USER:$ONOS_PASS -X POST http://$ONOS_CONTROLLER_IP:8181/onos/v1/flows --header "Content-Type:application/json" --data '{
  "flows": [{
    "priority": 40000,
    "timeout": 0,
    "isPermanent": true,
    "deviceId": "of:0000000000000003",
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
          "type": "IPV4_SRC",
          "ip": "10.0.0.1/32"
        },
        {
          "type": "IPV4_DST",
          "ip": "10.0.0.2/32"
        }
      ]
    }
  }]
}'

# 2. 允許來自 h2 的流量轉發到 h1
curl --user $ONOS_USER:$ONOS_PASS -X POST http://$ONOS_CONTROLLER_IP:8181/onos/v1/flows --header "Content-Type:application/json" --data '{
  "flows": [{
    "priority": 40000,
    "timeout": 0,
    "isPermanent": true,
    "deviceId": "of:0000000000000004",
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
          "type": "IPV4_SRC",
          "ip": "10.0.0.2/32"
        },
        {
          "type": "IPV4_DST",
          "ip": "10.0.0.1/32"
        }
      ]
    }
  }]
}'

# 3. 允許所有的 ICMP 流量（ping）
curl --user $ONOS_USER:$ONOS_PASS -X POST http://$ONOS_CONTROLLER_IP:8181/onos/v1/flows --header "Content-Type:application/json" --data '{
  "flows": [{
    "priority": 30000,
    "timeout": 0,
    "isPermanent": true,
    "deviceId": "of:0000000000000003",
    "treatment": {
      "instructions": [
        {
          "type": "OUTPUT",
          "port": "CONTROLLER"
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
        }
      ]
    }
  }]
}'

# 4. 設置 TCP 流量優先轉發
curl --user $ONOS_USER:$ONOS_PASS -X POST http://$ONOS_CONTROLLER_IP:8181/onos/v1/flows --header "Content-Type:application/json" --data '{
  "flows": [{
    "priority": 50000,
    "timeout": 0,
    "isPermanent": true,
    "deviceId": "of:0000000000000004",
    "treatment": {
      "instructions": [
        {
          "type": "OUTPUT",
          "port": "3"
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
          "protocol": 6
        }
      ]
    }
  }]
}'

# 5. 阻止來自特定 IP 的流量
curl --user $ONOS_USER:$ONOS_PASS -X POST http://$ONOS_CONTROLLER_IP:8181/onos/v1/flows --header "Content-Type:application/json" --data '{
  "flows": [{
    "priority": 60000,
    "timeout": 0,
    "isPermanent": true,
    "deviceId": "of:0000000000000003",
    "treatment": {
      "instructions": []
    },
    "selector": {
      "criteria": [
        {
          "type": "ETH_TYPE",
          "ethType": "0x0800"
        },
        {
          "type": "IPV4_SRC",
          "ip": "10.0.0.3/32"
        }
      ]
    }
  }]
}'

# 6. 允許 UDP 流量轉發
curl --user $ONOS_USER:$ONOS_PASS -X POST http://$ONOS_CONTROLLER_IP:8181/onos/v1/flows --header "Content-Type:application/json" --data '{
  "flows": [{
    "priority": 30000,
    "timeout": 0,
    "isPermanent": true,
    "deviceId": "of:0000000000000004",
    "treatment": {
      "instructions": [
        {
          "type": "OUTPUT",
          "port": "CONTROLLER"
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
          "protocol": 17
        }
      ]
    }
  }]
}'
