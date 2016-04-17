#!/bin/bash

DOCKER_IMAGE_TAG="dockerkeepassxdeb"
VERSION="2.0.2"

docker_image_exists () {
  docker images -q ${DOCKER_IMAGE_TAG}
}

build_image () {
  docker build \
    --build-arg=uid="$(id -u)" \
    --build-arg=version="${VERSION}" \
    -t ${DOCKER_IMAGE_TAG} \
    .
}

cleanup_before () {
  local p_dir=${PWD}/package
  if [ -d ${p_dir} ] ; then
    rm -f ${p_dir}/*
  fi
}

get_package () {
  local p_dir=${PWD}/package
  mkdir -p ${p_dir}
  docker run --rm -v ${p_dir}:/package ${DOCKER_IMAGE_TAG}
}

if ! docker_image_exists ; then
  build_image
fi

cleanup_before
get_package
