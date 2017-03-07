FROM java:8-jre-alpine

RUN apk add --no-cache curl openssl jq

# https://dist.xebialabs.com/xl-release-trial.zip
ENV version 6.1.0
ENV root /lib
ENV home ${root}/xl-release-server

RUN wget -q \
      https://s3-us-west-2.amazonaws.com/xlstuff/XL-Release-6.1.0-server.zip?X-Amz-Date=20170307T091146Z&X-Amz-Expires=300&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Signature=5a81bcc933429c06f61be537ecf4cd65d21b909ce758f02f0cc1432419216073&X-Amz-Credential=ASIAINI37HY7OZPDEAZA/20170307/us-west-2/s3/aws4_request&X-Amz-SignedHeaders=Host&x-amz-security-token=FQoDYXdzEBIaDIajRHSLPmg8a4zLRiL6AW%2Bqb0jkJ%2BJOObXyN1cqhXRmksf85KNoYW5XvX8wPuDO4%2BfaO1YTEPULwX9u0Ta1Ipiy4sVrc4aVM00d85Iu3ORI31SHT4R5PGPzIV5naKiiNpLXcZzWUZ20HwWCMI4y/mnXmWxgvSKTAAW3nky2Yva1qWPQCbpD7tOHzEYPntQs4AN2Le5EjlL5wGPq0d1AbLg7QknxMniJeIk/t1SjETmkX9vTFVttPoM9jrA14rmFcIELe6KF2xbAP0IggFePCfhjqFKC0un76Pfty3m/GKHXRdJGbHFbjwCzuF70kxtsjfKscMUwI41eUGenC%2Bk2aXgk0uLBgPbsL60olsD5xQU%3D \
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

WORKDIR ${home}/bin

RUN ["./run.sh", "-setup", "-reinitialize", "-force", "-setup-defaults", "./bin/xlrelease.answers"]

EXPOSE 5516

CMD ["./run.sh"]
