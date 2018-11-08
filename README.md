# dc-project
Using Serf and Consul for distributed container service discovery problem


## Usage
1. Install Docker
2. Build docker image from source ```$ docker build -t swapnilmg/serfnode .```
3. Source rc file ```$ . .rcSerfnode```
4. Source rc file ```$ . .rcConsulnode```
5. Start cluster of 5 serfnodes ```$ {serf/consul}-start-cluster 5```
6. To enter in bash shell of {serfnode4/consulnode4} ```$ docker exec -i -t serfnode4 /bin/bash```
7. Check Service discovery ```root@serfnode4:/# serf members```
8. Access primary serfnode webserver ```root@serfnode4:/# curl http://172.17.0.99```
9. Open new terminal and force stop serfnode0 ```$ docker stop serfnode0```
10. Check Service dicovery and status of serfnode0 from serfnode4 ```root@serfnode4:/# serf members```
11. Access new primary serfnode webserver ```root@serfnode4:/# curl http://172.17.0.99```
