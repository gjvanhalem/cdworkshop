# CD Workshop

## Intro

In this workshop we learn to use some tools and applications to create a continuous delivery pipeline. We use a dev instance in AWS to prevent local issues with our laptops. This dev machine also has a high speed internet connection, so downloading images won't delay our learning process.

- Git
- Docker
- Docker-Compose
- Jenkins
- XL Deploy
- XL Release

Look into the some files of this repository:

- ./dockerfiles/jenkins/Dockerfile
- ./dockerfiles/xldeploy/Dockerfile
- ./dockerfiles/xlrelease/Dockerfile
- ./docker-compose.yml
- ./provision.sh

Open link in your e-mail.

## Connect
Connect to your dev instance. 

```bash
ssh -i ~/path/to/CDWORKSHOP.pem ec2-user@IPADDRESS
# And switch to root to be god on the machine
sudo su -
```

## Docker hello-world
Lets play around with some docker commands. Remember you must be root to use Docker (sudo su -). 

```bash
# try some docker commands
docker ps
docker status
docker info
docker run hello-world

# Run a container in the background
docker run --name some-nginx -d -p 80:80 nginx
docker ps
docker images
curl localhost
# and try the http://ipaddress.xip.io in your browser

docker ps

# replace the 2bca.. for the id of the container
# of the previous command.
docker stop 2bcad
docker rm 2bcad
docker rmi nginx
```

## Checkout git

```bash
mkdir /var/work
git clone https://github.com/martijnvandongen/cdworkshop.git

# before exec next command, get url from e-mail
# make sure the credentials name remains
git clone https://gist.github.com/martijnvandongen/342jh23kj4h23kj42h credentials
```

It looks like:

```
TREE
```

## Boot applications

```bash
cd /var/work/cdworkshop
docker-compose up -d
```

Now each container can access other containers by the name and the INTERNAL port. For example: XL Release can access XL Deploy via

## Log in

Try to login to the several applications. Remember your applications are only accessible with the right IP-addresses and everything will be removed after the workshop.

|Application|Public|Docker Host|Container|User|Password|
|---|---|---|---|---|---|
|XL Deploy|http://youripaddress.nip.io:4516|http://localhost:4516|http://xldeploy:4516|admin|password|
|XL Release|http://youripaddress.nip.io:5516|http://localhost:5516|http://xldeploy:5516|admin|password|
|Jenkins|http://youripaddress.nip.io:8080|http://localhost:8080|http://jenkins:8080|N/A|N/A|
|Gitlab|http://youripaddress.nip.io:8090|http://localhost:8090|http://gitlab|root|password|
|Target|http://youripaddress.nip.io|http://localhost:80|http://dummy|N/A|N/A|

## Manual Configuration
In this part we'll configure Gitlab, Jenkins, XL Deploy and XL Release manually. If you want to skip this part, go to the next chapter where (almost) everything is configured automatically. 

### Create git repo

Lets first start with a repo and add our example website to it.

1. Login to Gitlab
2. Create a new project "website" public
3. ```cd /var/work```
4. ```git clone http://localhost:8090/root/website.git```
5. ```cd website```
5. ```cp /var/work/cdworkshop/dockerfiles/dummy/index.html .```
6. ```git add . && git commit -am "auto" && git push ```
7. Verify through the web interface

### Create Jenkins jobs

Now create a Jenkins job which gets the source from gitlab, creates a package and upload it to XL Deploy. (No trigger in Jenkins, it's done with XLR, and no deploy with Jenkins, this trigger will be sent by XLR)

1. Login to Jenkins
2. Manage Jenkins > Configure System, enter XL Deploy: http://xldeploy:4516 / admin / admin / password
2. Create new jobs (Name: buildwebsite, type: Freestyle Project)
4. Enable Source Code Management: Git
5. Repository URL: http://gitlab/root/website.git
6. Credentials add: root / password
7. Remove Branches to build (all branches)
7. Skip Build Steps
7. Add Post-build Action: Deploy with XL Deploy
8. Select Global server credential
9. Application: Applications/website
10. Version: $BUILD_NUMBER
11. Check Package application
12. Deployable Type: file.File, Name: index.html, Location: index.html
13. Property targetPath=/var/www/html
14. Check Publish package to XL Deploy, Generated

### Configure XL Deploy

Now configure XL Deploy, create the whole infrastructure.

1. Create Applications/website (Application)
2. Create Applications/website/examplepackage (Deployment Package)
3. Create Applications/website/examplepackage/index.html (Type: file.File Target Path: /var/www/html)
2. Create Infrastructure/target (see table below)
3. Check Connection
3. Create Environments/target, select the infrastructure component
4. Test a deployment manually

|Key|Value|
|---|---|
|Operating System|UNIX|
|Connection Type|SCP|
|Address|dummy|
|Port|22|
|Username|root|
|Password|password|

### Configure XL Release

1. Add XL Deploy Server to XL Release
2. Add Git Repository: http://gitlab/root/website.git
3. Add Jenkins: http://jenkins:8080
4. Create New Template
5. Add ${version} variable
5. Add Jenkins Build step (build number: ${version})
6. Add XL Deploy Step (package: website/${version}, Environment: target)
7. Add Trigger Git:Poll
8. Title: Git Commit, Release Title: Automated Release ${commitId}, Enabled: True. Just select repository.

### Commit & Watch
When change something in the source code, xl release is triggered. Keep all Windows open and see/show what happens.

```bash
cd /var/work/website
vi index.html
# change some contents of the html
git add .
git commit -am "some comment for your commit"
git push
```

## Automatic Configuration
To provision most of the things from the manual configuration chapter, execute the following command.

```bash
./provision.sh
```
After this script ran, do some manual actions.

TODO

## Setup Dev Platform (instructor)
This is just for the instructor to setup the platform and send an e-mail with some web links and the pem file to connect.

1. Create a key pair
2. Upload and execute ./cloudformation/devinstances.json
3. Add some source ip addresses to the security group
4. Add users-and-ipaddresses.txt
4. Create a gist.github.com repo secret
5. ```git clone ```
6. Copy resource files in folder
7. ```git add . && git commit -am "auto" && git push```
8. Send e-mail:

```
pem file
link to https://github.com/martijnvandongen/cdworkshop
link to gist url
```
