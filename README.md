# Distributed System of Micro Services


You can use the [editor on GitHub](https://github.com/sharath29/dc-project/edit/master/README.md) to maintain and preview the content for your website in Markdown files.

## What is the project about?
Service discovery

## What is serf and consul?
Serf is a tool for cluster membership, failure detection, and orchestration that is decentralized, fault-tolerant and highly available. Serf runs on every major platform: Linux, Mac OS X, and Windows. It is extremely lightweight: it uses 5 to 10 MB of resident memory and primarily communicates using infrequent UDP messages.  

Serf uses an efficient gossip protocol to solve three major problems:  

-Membership: Serf maintains cluster membership lists and is able to execute custom handler scripts when that membership changes. For example, Serf can maintain the list of web servers for a load balancer and notify that load balancer whenever a node comes online or goes offline.

-Failure detection and recovery: Serf automatically detects failed nodes within seconds, notifies the rest of the cluster, and executes handler scripts allowing you to handle these events. Serf will attempt to recover failed nodes by reconnecting to them periodically.

-Custom event propagation: Serf can broadcast custom events and queries to the cluster. These can be used to trigger deploys, propagate configuration, etc. Events are simply fire-and-forget broadcast, and Serf makes a best effort to deliver messages in the face of offline nodes or network partitions. Queries provide a simple realtime request/response mechanism.

## What is gossip protocol?
Add from hashicorp

## Steps to reproduce

Below are the steps to reproduce the project results.

### Installing Docker

1. Install docker for ubuntu [link](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
2. Check installation status by typing docker in terminal.
```
$ docker
A self-sufficient runtime for containers

Options:
      --config string      Location of client config files (default "/home/sharath/.docker")
  -D, --debug              Enable debug mode
  -H, --host list          Daemon socket(s) to connect to
  -l, --log-level string   Set the logging level
                           ("debug"|"info"|"warn"|"error"|"fatal") (default "info")
      --tls                Use TLS; implied by --tlsverify
      --tlscacert string   Trust certs signed only by this CA (default
                           "/home/sharath/.docker/ca.pem")
      --tlscert string     Path to TLS certificate file (default
                           "/home/sharath/.docker/cert.pem")
      --tlskey string      Path to TLS key file (default "/home/sharath/.docker/key.pem")
      --tlsverify          Use TLS and verify the remote
  -v, --version            Print version information and quit

```

### Setting up serf-nodes
1. Build docker image from source `$ docker build -t sharath/serfnode` .
2. Source rc file `$ . .rcSerfnode`
3. Start cluster of 5 serfnodes `$ serf-start-cluster 5`
4. Enter in bash shell of serfnode4 `$ docker exec -i -t serfnode4 /bin/bash`
5. Check Service discovery `root@serfnode4:/# serf members`
6. Access primary serfnode webserver `root@serfnode4:/# curl http://172.17.0.99`
7. Open new terminal and force stop serfnode0 `$ docker stop serfnode0`
8. Check Service dicovery and status of serfnode0 from serfnode4 `root@serfnode4:/# serf members`
9. Access new primary serfnode webserver `root@serfnode4:/# curl http://172.17.0.99`

### Setting up consul-nodes

1. steps
2. involved
3. build consul image



[Link](url) and ![Image](src)


## Comparison and logs


For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).


## References


