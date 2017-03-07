FROM java:8-jre-alpine

RUN apk add --no-cache curl openssl

ENV GIT_ENDPOINT http://localhost
ENV version 5.1.4
ENV root /lib
ENV home ${root}/xl-deploy-server

RUN wget -q \
      https://s3-us-west-2.amazonaws.com/xlstuff/XL-Deploy-5.1.4-server.zip?X-Amz-Date=20170307T091332Z&X-Amz-Expires=300&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Signature=faf0ed22da01ba7fbda3198bebc7f2557a077422af3602c1f467065f4806451f&X-Amz-Credential=ASIAINI37HY7OZPDEAZA/20170307/us-west-2/s3/aws4_request&X-Amz-SignedHeaders=Host&x-amz-security-token=FQoDYXdzEBIaDIajRHSLPmg8a4zLRiL6AW%2Bqb0jkJ%2BJOObXyN1cqhXRmksf85KNoYW5XvX8wPuDO4%2BfaO1YTEPULwX9u0Ta1Ipiy4sVrc4aVM00d85Iu3ORI31SHT4R5PGPzIV5naKiiNpLXcZzWUZ20HwWCMI4y/mnXmWxgvSKTAAW3nky2Yva1qWPQCbpD7tOHzEYPntQs4AN2Le5EjlL5wGPq0d1AbLg7QknxMniJeIk/t1SjETmkX9vTFVttPoM9jrA14rmFcIELe6KF2xbAP0IggFePCfhjqFKC0un76Pfty3m/GKHXRdJGbHFbjwCzuF70kxtsjfKscMUwI41eUGenC%2Bk2aXgk0uLBgPbsL60olsD5xQU%3D \
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