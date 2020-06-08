#!/bin/bash
set -ex

pushd $SCRIPT_DIR/base
pushd zookeeper
echo "Building Zookeepr image"
docker build -t atsgen/zookeeper:3.4.14 .
popd

pushd cassandra
echo "Building Cassandra image"
docker build -t atsgen/cassandra:3.11.6 .
popd

pushd rabbitmq
echo "Building Rabbitmq image"
docker build -t atsgen/rabbitmq:3.7.26 .
popd

pushd redis
echo "Building Redis image"
docker build -t atsgen/redis:5.0.9 .
popd
popd

