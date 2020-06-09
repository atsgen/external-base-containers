#!/bin/bash
set -ex
export SCRIPT_DIR=$(realpath $(dirname $0))
source $SCRIPT_DIR/parse-env.sh

build_arg_opts+=" --build-arg CONTRAIL_REGISTRY=${CONTRAIL_REGISTRY}"
build_arg_opts+=" --build-arg CONTRAIL_CONTAINER_TAG=${CONTRAIL_CONTAINER_TAG}"
build_arg_opts+=" --build-arg LINUX_DISTR_VER=${LINUX_DISTR_VER}"
build_arg_opts+=" --build-arg LINUX_DISTR=${LINUX_DISTR}"
build_arg_opts+=" --build-arg YUM_ENABLE_REPOS=\"$YUM_ENABLE_REPOS\""
build_arg_opts+=" --build-arg VENDOR_NAME=${VENDOR_NAME}"
build_arg_opts+=" --build-arg VENDOR_DOMAIN=${VENDOR_DOMAIN}"

pushd cassandra
docker build -t $CONTRAIL_REGISTRY/tungsten-external-cassandra:$CONTRAIL_CONTAINER_TAG .
popd

pushd zookeeper
docker build -t $CONTRAIL_REGISTRY/tungsten-external-zookeeper:$CONTRAIL_CONTAINER_TAG .
popd

pushd rabbitmq
docker build -t $CONTRAIL_REGISTRY/tungsten-external-rabbitmq:$CONTRAIL_CONTAINER_TAG .
popd

pushd redis
docker build -t $CONTRAIL_REGISTRY/tungsten-external-redis:$CONTRAIL_CONTAINER_TAG .
popd

