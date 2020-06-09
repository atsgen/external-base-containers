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

pushd $SCRIPT_DIR
for dir in $(ls -d */); do
  pushd $dir
  CONTAINER_NAME="tungsten-external-${dir%?}"
  echo $CONTAINER_NAME
  build_arg_name_opt=" --build-arg CONTAINER_NAME=${CONTAINER_NAME}"
  docker build $build_arg_opts $build_arg_name_opt -t $CONTRAIL_REGISTRY/$CONTAINER_NAME:$CONTRAIL_CONTAINER_TAG .
  popd
done
popd
