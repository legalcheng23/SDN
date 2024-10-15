curl -X POST -H "Content-Type: application/json" http://172.17.0.5:8181/onos/v1/flows/of:0000000000000001 -d @./flow_h1_to_h2.json --user onos:rocks
curl -X POST -H "Content-Type: application/json" http://172.17.0.5:8181/onos/v1/flows/of:0000000000000002 -d @./flow_h2_to_h1.json --user onos:rocks
curl -X POST -H "Content-Type: application/json" http://172.17.0.5:8181/onos/v1/flows/of:0000000000000001 -d @./flow_h1_arp.json --user onos:rocks
curl -X POST -H "Content-Type: application/json" http://172.17.0.5:8181/onos/v1/flows/of:0000000000000002 -d @./flow_h2_arp.json --user onos:rocks
