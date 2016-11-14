#!/bin/sh

giturl="http://gitlab:8090/root/demo"
gituser="root"
gitpass="password"
jenkinsurl="http://jenkins:8080"
jenkinsuser=""
jenkinspass=""
xldeployurl="http://xldeploy:4516"
xldeployuser="admin"
xldeploypassword="password"
appname="myapp"
buildjobname="build"
testjobname="test"

# Create an xldeployserver
curl -u admin:password \
	-X POST \
	--silent \
	--header "Content-Type:application/json;charset=UTF-8" \
	--data '{"id":"Configuration/Deployit/xldeployserver","username":"'$xldeployuser'","password":"'$xldeploypass'","url":"'$xldeployurl'","type":"xlrelease.DeployitServerDefinition"}' \
	http://localhost:5516/deployit/servers

# Create a Git Server
gitid=$(curl -u admin:password \
	--silent \
	-X POST \
	--header "Content-Type:application/json;charset=UTF-8" \
	--data '{"type":"git.Repository","properties":{"title":"gitserver","url":"'$giturl'","username":"'$gituser'","password":"'$gitpass'","proxyHost":"","proxyPort":""}}' \
	http://localhost:5516/configurations | jq -r '.id')

# Create a Jenkins Server
jenkinsid=$(curl -u admin:password \
	--silent \
	-X POST \
	--header "Content-Type:application/json;charset=UTF-8" \
	--data '{"type":"jenkins.Server","properties":{"title":"jenkinsserver","url":"'$jenkinsurl'","username":"'$jenkinsuser'","password":"'$jenkinspass'","proxyHost":null,"proxyPort":null,"pollInterval":1}}' \
	http://localhost:5516/configurations | jq -r '.id')

# Insert variables in template
sed -e "s/GITID/$gitid/g" \
	-e "s/JENKINSID/$jenkinsid/g" \
	-e "s/JENKINSUSER/$jenkinsuser/g" \
	-e "s/JENKINSPASS/$jenkinspass/g" \
	-e "s/GITUSER/$gituser/g" \
	-e "s/GITPASS/$gitpass/g" \
	-e "s/XLDEPLOYUSER/$xldeployuser/g" \
	-e "s/XLDEPLOYPASS/$xldeploypass/g" \
	-e "s/APPNAME/$appname/g" \
	-e "s/BUILDJOBNAME/$buildjobname/g" \
	-e "s/TESTJOBNAME/$testjobname/g" \
	./scripts/xlrelease.json > ./scripts/xlreleasesed.json

# Import the template
curl -u admin:password \
	--silent \
	-X POST \
	--header "Content-Type:application/json;charset=UTF-8" \
	--data @./scripts/xlreleasesed.json \
	http://localhost:5516/api/v1/templates/import

PRIVATE_TOKEN=$(curl -L --silent --data "login=root&password=password" http://localhost:8090/api/v3/session | jq -r .private_token)

curl -L --silent \
  --data "name=demo" \
  --data "public=true" \
  --header "PRIVATE-TOKEN: ${PRIVATE_TOKEN}" \
  "http://localhost:8090/api/v3/projects"


exit 0




