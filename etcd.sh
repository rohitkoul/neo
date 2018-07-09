#!/bin/bash
HOSTIP="127.0.0.1"
docker run -d -v /usr/share/ca-certificates/:/etc/ssl/certs --net=host \
 --name etcd0 quay.io/coreos/etcd:v2.3.8 \
 -name etcd0 \
 -listen-client-urls http://$HOSTIP:12379 \
 -advertise-client-urls http://$HOSTIP:12379 \
 -listen-peer-urls http://$HOSTIP:12380 \
 -initial-advertise-peer-urls http://$HOSTIP:12380 \
 -initial-cluster-token etcd-cluster-1 \
 -initial-cluster etcd0=http://$HOSTIP:12380,etcd1=http://$HOSTIP:22380,etcd2=http://$HOSTIP:32380 \
 -initial-cluster-state new \
 --enable-pprof

docker run -d -v /usr/share/ca-certificates/:/etc/ssl/certs --net=host \
 --name etcd1 quay.io/coreos/etcd:v2.3.8 \
 -name etcd1 \
 -listen-client-urls http://$HOSTIP:22379 \
 -advertise-client-urls http://$HOSTIP:22379 \
 -listen-peer-urls http://$HOSTIP:22380 \
 -initial-advertise-peer-urls http://$HOSTIP:22380 \
 -initial-cluster-token etcd-cluster-1 \
 -initial-cluster etcd0=http://$HOSTIP:12380,etcd1=http://$HOSTIP:22380,etcd2=http://$HOSTIP:32380 \
 -initial-cluster-state new \
 --enable-pprof

docker run -d -v /usr/share/ca-certificates/:/etc/ssl/certs --net=host \
 --name etcd2 quay.io/coreos/etcd:v2.3.8 \
 -name etcd2 \
 -listen-client-urls http://$HOSTIP:32379 \
 -advertise-client-urls http://$HOSTIP:32379 \
 -listen-peer-urls http://$HOSTIP:32380 \
 -initial-advertise-peer-urls http://$HOSTIP:32380 \
 -initial-cluster-token etcd-cluster-1 \
 -initial-cluster etcd0=http://$HOSTIP:12380,etcd1=http://$HOSTIP:22380,etcd2=http://$HOSTIP:32380 \
 -initial-cluster-state new \
 --enable-pprof
