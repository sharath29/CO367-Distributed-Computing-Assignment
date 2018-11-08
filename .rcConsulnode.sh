#!/bin/bash

: ${NODE_PREFIX=consulnode}
: ${MYDOMAIN:=sharath.nitk.edu}
: ${IMAGE:=progrium/consul }
: ${DOCKER_OPTS:="--cap-add=NET_ADMIN --dns=127.0.0.1 -p 8400:8400 -p 8500:8500 -p 8600:53/udp"}
: ${DEBUG:=1}

consulnode-settings() {
  cat <<EOF
  NODE_PREFIX=$NODE_PREFIX
  MYDOMAIN=$MYDOMAIN
  IMAGE=$IMAGE
  DOCKER_OPTS=$DOCKER_OPTS
  CON_JOIN_IP=$CON_JOIN_IP
EOF
}

debug() {
  [ -z $DEBUG ] || echo [DEBUG] $@
}

consul-start-first() {
  NUM_OF_NODES=${1:-3}
  ROLE="server"
  CMD="docker run -d $DOCKER_OPTS --name consulnode0 -h ${NODE_PREFIX}${NUMBER}.$MYDOMAIN $IMAGE -$ROLE -bootstrap-expect $NUM_OF_NODES"
  debug $CMD
  $CMD
}

get-join-ip() {
  : ${CON_JOIN_IP:=$(docker inspect --format="{{.NetworkSettings.IPAddress}}" ${NODE_PREFIX}0)}
  #"
  debug CON_JOIN_IP=$CON_JOIN_IP
}

consul-start-node() {
  get-join-ip
  : ${CON_JOIN_IP:?"CON_JOIN_IP is needed"}
  NUMBER=${1:?"please give a <NUMBER> parameter it will be used as node<NUMBER>"}
  if [ $# -eq 1 ] ;then
    MORE_OPTIONS="-d"
  else
    shift
    MORE_OPTIONS="$@"
  fi
  ROLE="standby"
  CMD="docker run $MORE_OPTIONS --name ${NODE_PREFIX}$NUMBER -h ${NODE_PREFIX}${NUMBER}.$MYDOMAIN $IMAGE -join $CON_JOIN_IP"
  debug $CMD
  $CMD
}

consul-start-cluster() {
  NUM_OF_NODES=${1:-3}
  echo starting $NUM_OF_NODES docker container

  consul-start-first $NUM_OF_NODES
  for i in $(seq $((NUM_OF_NODES - 1))); do
    consul-start-node $i
  done

}

consul-clean(){
  i=${1:?"please give a <NUMBER> parameter"}
  while [ $i -ge 0 ]; do docker stop consulnode$i; docker rm consulnode$i; ((i--)); done
}
