#!/bin/bash
if [ -z $1 ]
  then
    echo please input version number 
    exit 1
fi
DOCKER_PASSWORD_FILE=~/.docker_hub_password
if [ ! -f $DOCKER_PASSWORD_FILE ]; then
  echo docker hub password not exists in $DOCKER_PASSWORD_FILE
  exit 1
fi

VERSION=$1
SRC_ROOT=src/
TARGET_ROOT=target/stock/
CONFIG_FILE=WEB-INF/classes/application.yml
CHECK_FILE=assets/check.html
echo VERSION=$VERSION
echo SRC_ROOT=$SRC_ROOT
echo TARGET_ROOT=$TARGET_ROOT
echo CONFIG_FILE=$CONFIG_FILE
echo CHECK_FILE=$CHECK_FILE

# copy src file
rm -rf "${TARGET_ROOT}${CONFIG_FILE}" "${TARGET_ROOT}${CHECK_FILE}"
cp "${SRC_ROOT}${CONFIG_FILE}" "${TARGET_ROOT}${CONFIG_FILE}"
cp "${SRC_ROOT}${CHECK_FILE}" "${TARGET_ROOT}${CHECK_FILE}"

# rebuild war file
#rm -rf ./stock.war
#cd stock && jar -cvf stock.war *
#cd .. && mv stock/stock.war .

# build docker image
cat $DOCKER_PASSWORD_FILE | docker login --username=s-docker-image@rishiqing --password-stdin registry-internal.cn-beijing.aliyuncs.com 
docker build -t registry-internal.cn-beijing.aliyuncs.com/rsq-project/rishiqing-stock:$VERSION .
docker push registry-internal.cn-beijing.aliyuncs.com/rsq-project/rishiqing-stock:$VERSION
