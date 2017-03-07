FROM java:8-jre-alpine

RUN apk add --no-cache curl openssl

ENV GIT_ENDPOINT http://localhost
ENV version 5.1.4
ENV root /lib
ENV home ${root}/xl-deploy-server

RUN wget -q \
      https://s3-us-west-2.amazonaws.com/xlstuff/XL-Deploy-5.1.4-server.zip \
      -O /tmp/xld.zip \
  && unzip \
      /tmp/xld.zip \
      -d ${root} \
  && mv \
      ${root}/xl-deploy-${version}-server \
      ${root}/xl-deploy-server \
  && rm -R \
      /tmp/xld.zip \
      ${home}/serviceWrapper \
      ${home}/samples \
      ${home}/importablePackages/*

ADD xldeploy.answers ${home}/bin/xldeploy.answers

WORKDIR ${home}/bin
RUN ["./run.sh", "-setup", "-reinitialize", "-force", "-setup-defaults", "./bin/xldeploy.answers"]


#Provision XLDeploy...

EXPOSE 4516

CMD ["./run.sh"]