FROM java:8-jre-alpine

RUN apk add --no-cache curl openssl

ENV GIT_ENDPOINT http://localhost
ENV version 6.2.1
ENV root /lib
ENV home ${root}/xl-deploy-server

RUN wget -q \
      http://maven.rabobank.nl/nexus/service/local/repositories/ci-devops-support-release/content/com/xebialabs/XL-Deploy/6.2.1/XL-Deploy-6.2.1-server.zip \
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
ADD xldeploy.txt ${home}/lib/xl-deploy-server/conf/deployit-license.lic

WORKDIR ${home}/bin
RUN ["./run.sh", "-setup", "-reinitialize", "-force", "-setup-defaults", "./bin/xldeploy.answers"]


#Provision XLDeploy...

EXPOSE 4516

CMD ["./run.sh"]