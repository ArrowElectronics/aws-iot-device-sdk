# Welcome to aws-iot-thing-sdk!

The Arrow AWS IoT Starter Kit powered by Amazon AWS. This document will help you setup your device to use Amazon
AWS IoT services. Currently supports (DragonBoard , Beaglebone)

## DragonBoard

For DragonBoard related instructions please follow the steps in [DragonBoard Instructions](DragonBoard.md) before continuing.

### Sample Applications

#### DragonConnect

Connects and communicates with the DragonBoard&trade;. Written in C and
integrating a 2-way MQTT channel through Amazon AWS, DragonConnect
reads/writes to Ubuntu file handlers allowing control of on-board IO.

The <a href="https://github.com/ArrowElectronics/aws-iot-dragonconnect-c" target="_blank">quick getting started guide</a> and source code for the project is available at <a href="https://github.com/ArrowElectronics/aws-iot-dragonconnect-c" target="_blank">GitHub</a>.

#### DragonPulse

Utilizes NodeJS, MQTT protocol, and Amazon AWS services, to interact with
Ubuntu shell commands. Extract performance and summary statistics to
remotely monitor top CPU consumption, memory usage, network traffic,
and disk space.

The <a href="https://github.com/ArrowElectronics/aws-iot-dragonpulse-js/" target="_blank">quick getting started guide</a> and source code for the project is available at <a href="https://github.com/ArrowElectronics/aws-iot-dragonpulse-js/" target="_blank">GitHub</a>.

## Beaglebone

For Beaglebone related instructions please follow the steps in [Beaglebone Instructions](Beaglebone.md) before continuing.

### Sample Applications

#### Ti SensorTag

Utilizes NodeJS, MQTT protocol, and Amazon AWS services, to interact with bluetooth low energy TI sensor tags to capture available sensor data includes, but not limited to IR thermopile temperature, 9-axis motion, digitial humidity, altimeter/pressure, ambient light, buzzer, magnet sensor, and digital microphone.

The <a href="https://github.com/ArrowElectronics/aws-iot-tisense-js" target="_blank">quick getting started guide</a> and source code for the project is available at <a href="https://github.com/ArrowElectronics/aws-iot-tisense-js" target="_blank">GitHub</a>.

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
$ cd ~
$ git clone https://github.com/ArrowElectronics/aws-iot-device-sdk.git 
$ cd aws-iot-device-sdk/scripts
$ ./install.sh
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
