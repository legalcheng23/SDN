curl -X POST -H "content-type:application/json" http://172.17.0.5:8181/onos/v1/flows/of:0000000000000001 -d @./test_1.json --user onos:rocks
curl -X POST -H "content-type:application/json" http://172.17.0.5:8181/onos/v1/flows/of:0000000000000001 -d @./test_1r.json --user onos:rocks
curl -X POST -H "content-type:application/json" http://172.17.0.5:8181/onos/v1/flows/of:0000000000000002 -d @./test_2.json --user onos:rocks
curl -X POST -H "content-type:application/json" http://172.17.0.5:8181/onos/v1/flows/of:0000000000000002 -d @./test_2r.json --user onos:rocks
curl -X POST -H "content-type:application/json" http://172.17.0.5:8181/onos/v1/flows/of:0000000000000001 -d @./test_1arp.json --user onos:rocks
curl -X POST -H "content-type:application/json" http://172.17.0.5:8181/onos/v1/flows/of:0000000000000002 -d @./test_2arp.json --user onos:rocks
