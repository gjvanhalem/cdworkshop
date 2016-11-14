# CD Workshop

## Intro

In this workshop we learn to use some tools and applications to create a continuous delivery pipeline. 

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

## Connect
Connect to your dev instance. 

```bash
ssh -i ~/path/to/CDWORKSHOP.pem ec2-user@IPADDRESS
# And switch to root to be god on the machine
sudo su -
```

## Docker hello-world
```bash
# try some docker commands
docker ps
docker status
docker info
docker run hello-world
docker run --name some-nginx -d -p 80:80 nginx
docker ps
docker images
# try the http://ipaddress in your browser
docker ps
docker stop 2bcad
docker rm 2bcad
docker rmi nginx
```

## Checkout git

```bash
mkdir /var/work
git clone https://github.com/martijnvandongen/cdworkshop.git
# Create credential files
cd /var/work/credentials

wget 
```

## Boot applications

```bash
cd /var/work/cdworkshop
docker-compose up -d
```

## Log in

Try to login to the several applications. Remember your applications are only accessible with the right IP-addresses and everything will be removed after the workshop.

|Application|URL|User|Password|
|---|---|---|---|---|
|XL Deploy|http://youripaddress.nip.io:4516|admin|password|
|XL Release|http://youripaddress.nip.io:5516|admin|password|
|Jenkins|http://youripaddress.nip.io:8080|N/A|N/A|
|Gitlab|http://youripaddress.nip.io|root|password|
|Target|http://youripaddress.nip.io|N/A|N/A|

## Provision Applications
To provision the applications execute the following command.

```bash
./provision.sh
```
After this script ran, do some manual actions.

1. Login to Jenkins
2. Add a job...
3. Enable trigger in XL Release

## Play around!
This is the part of the workshop which is most interesting to our users.

### Commit & Watch
When change something in the source code, xl release is triggered. Keep all Windows open and see/show what happens.

```bash
cd /var/work
git clone 
vi index.html
git add .
git commit -am "some comment for your commit"
git push
```

### Demo of the CD pipeline

1. XL Deploy functionalities
2. XL Release functionalities

## Setup Dev Platform (instructor)
This is just for the instructor to setup the platform.

1. Create a key pair
2. Upload and exec ./cloudformation/devinstances.json
3. Add some source ip addresses of the users
