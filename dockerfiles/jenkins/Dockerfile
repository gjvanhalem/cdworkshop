FROM jenkins:alpine

ENV JAVA_OPTS "-Dhudson.Main.development=true -Djenkins.install.runSetupWizard=false"

USER root

WORKDIR /usr/share/jenkins/ref/plugins
RUN install-plugins.sh git deployit-plugin

