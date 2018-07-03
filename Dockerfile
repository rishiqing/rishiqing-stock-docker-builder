FROM registry-internal.cn-beijing.aliyuncs.com/rsq-public/tomcat:8.0.50-jre8

LABEL name="rishiqing-stock" \
       description="rishiqing stock system" \
       maintainer="solax, rishiqing group" \
       org="rishiqing"

# set default time zone to +0800 (Shanghai)
ENV TIME_ZONE=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone

ENV CATALINA_HOME /usr/local/tomcat
WORKDIR $CATALINA_HOME

RUN rm -rf webapps/ROOT/*
COPY target/stock webapps/ROOT
