FROM java:8-jre-alpine

RUN apk add --no-cache curl openssl jq

# https://dist.xebialabs.com/xl-release-trial.zip
ENV version 7.0.1
ENV root /lib
ENV home ${root}/xl-release-server

RUN wget -q \
      http://maven.rabobank.nl/nexus/service/local/repositories/ci-devops-support-release/content/com/xebialabs/XL-Release/7.0.1/XL-Release-7.0.1-server.zip \
      -O /tmp/xlr-server.zip \
    && unzip \
      /tmp/xlr-server.zip \
      -d ${root} \
    && mv \
      ${root}/xl-release-${version}-server \
      ${root}/xl-release-server \
    && rm -R \
      /tmp/xlr-server.zip \
      ${home}/serviceWrapper

ADD xlrelease.answers ${home}/bin/xlrelease.answers
ADD xlrelease.txt ${home}/conf/xl-release-license.lic

WORKDIR ${home}/bin

RUN ["./run.sh", "-setup", "-reinitialize", "-force", "-setup-defaults", "./bin/xlrelease.answers"]

EXPOSE 5516

CMD ["./run.sh"]
