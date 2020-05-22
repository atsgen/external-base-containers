#!/bin/bash
pushd zookeeper
docker build -t zookeeper:3.4.14 .
popd
