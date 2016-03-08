# Welcome to aws-iot-thing-sdk!

The Arrow AWS IoT Starter Kit powered by Amazon AWS. This document will help you setup your device to use Amazon
AWS IoT services. Currently supports (DragonBoard , Beaglebone)

## DragonBoard

For DragonBoard related instructions please follow the steps in [DragonBoard Instructions](DragonBoard.md) before continuing.

## Beaglebone

For Beaglebone related instructions please follow the steps in [Beaglebone Instructions](Beaglebone.md) before continuing.

## Obtain Amazon Access Key
Please have this information ready. 
In order for the aws-cli to connect to your aws-account it needs to be configures with your access Key ID and region: 
* Log into your AWS account [http://amazon.com/aws](Amazon AWS)
* Navigate to "My Account">"Security Credentials" to create the Access Key
* Click on "Access Keys (AccessKey ID and Secret Access Key)
* Click on "Create New Access Key", then use the information provided to fill out the configuration
* NOTE: it seems that AWS has IoT enabled only in the us-east-1, us-west-2, eu-west-1, and ap-northeast-1 regions

## Download and install the Arrow Electronics AWS-demo
```sh
$ cd ~/projects
$ git clone https://github.com/ArrowElectronics/aws-iot-device-sdk.git 
$ cd aws-iot-device-sdk/scripts
$ sudo ./install.sh
```
The installer will attempt to detect the device used and then ask for a default path to install software into. The default is /home/linaro/projects for DragonBoard and /home/debian/projects
pressing {Enter} will use the defaults

## Appendix

Test AWS client by using the following command 
```sh
$ aws help
```

If it returns with 'Could not find executable name "groff"', please install
```sh
$ sudo su
$ apt-get install groff
```


# License
This SDK is distributed under the
[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0),
see LICENSE.txt and NOTICE.txt for more information.
