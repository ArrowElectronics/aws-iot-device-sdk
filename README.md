# aws-iot-thing-sdk
# Welcome!

Thanks for trying out the DragonBoard&trade; 410c AWS IoT Starter Kit powered by Amazon AWS. This document will help you setup your DragonBoard to use Amazon AWS IoT services. :dragon_face:

# Arrow DragonBoard 410c

Arrow's DragonBoard&trade; 410c AWS IoT starter kit has the following contents:
* Arrow DragonBoard&trade; 410c development board (http://partners.arrow.com/campaigns-na/qualcomm/dragonboard-410c/awsiotstarterkit/)
* Power Supply 12v 2amp
* DragonConnect - Demo App written in C
* DragonPulse - Demo app written in NodeJS

![Image of Board Callout](https://github.com/ArrowElectronics/images/dragonboard_callouts.png)

Smaller than a standard playing card, the DragonBoard&trade; 410c packs a lot in a tiny footprint, including a quad-core 1.2Ghz Snapdragon 410 processor, 1GB RAM, 8GB SanDisk e.MMC storage, on-board WLAN, GPS, and Bluetooth.

![Image of IoT Stack](https://github.com/ArrowElectronics/images/iot_infographic.png)

The Starter Kit ecosystem can be setup in a matter of minutes by using a standard monitor and keyboard, connecting to the internet with the Dragonboard&trade;, provisioning your AWS account, and running the demos.

Combining the unique features of DragonBoard&trade; with Amazon Web Services creates an integrated ecosystem for bringing any project online.

# Getting Started

### Requirements
* Standard monitor
* HDMI cable to connect DragonBoard&trade; to monitor (HDMI->DVI or HDMI->HDMI)
* USB Keyboard
* USB Mouse
* Wi-Fi internet connection

## Configuring your AWS IoT Service

* Create an [AWS account](http://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/AMS5.0CreatingAnAWSAccount.html)
* Go to [AWS IoT](https://aws.amazon.com/iot/) and open up the AWS IoT Dashboard
* In the AWS IoT console, select "Create a resource"
![Image of AWS IoT Create Resource](https://github.com/ArrowElectronics/images/aws_iot_create_resource.png)

* Choose "Create a policy" - a policy is used to determine what IoT operations the owner of the certificate can perform.
  * name: `PubSubToAnyTopic`
  * action: `iot:*`
  * resources: `*`
  * make sure that "Allow" is checked
![Image of AWS IoT Create Policy](https://github.com/ArrowElectronics/images/aws_iot_create_policy.png)

* Choose "Create a certificate", this will present 2 options (Create with CSR or 1-Click Certificate Create), choose "1-Click Certificate Create"
![Image of AWS IoT 1-Click Certificate](https://github.com/ArrowElectronics/images/aws_iot_1click_certificate.png)

* Click on "Certificates", Choose the previously created certificate and under "Actions", Select "Activate"
![Image of AWS IoT Activate Certificate](https://github.com/ArrowElectronics/images/aws_iot_activate_certificate.png)

* Attach the IoT Policy to the certificate, by selecting "Attach a Policy" under "Actions"
  * Enter the name "PubSubToAnyTopic"
![Image of AWS IoT Attach Policy](https://github.com/ArrowElectronics/images/aws_iot_attach_policy.png)

* Download the public, private keys and the certificate - these will eventually reside on the DragonBoard&trade; device
  * certificate.pem.crt
  * private.pem.key

## Configuring the starter kit

Please perform the following steps:
* Connect the DragonBoard&trade; to the external monitor via HDMI connector
* Connect USB Keyboard and mouse

Login to the Dragonboard&trade;
**username** linaro
**password** linaro

### Setup Internet Connection

* In the bottom right of the deskop, left-click the network icon
![Image of Network Icon](https://github.com/ArrowElectronics/images/network_icon.png)

* Choose the appropriate network, enter password as necessary
![Image of Network Menu](https://github.com/ArrowElectronics/images/network_menu.png)

### Install and Update SDKs

* In the bottom left of the desktop, left-click the start-like icon 
![Image of Start Icon](https://github.com/ArrowElectronics/images/start_icon.png)

* Navigate to System Tools > LXTerminal
![Image of Start Icon](https://github.com/ArrowElectronics/images/terminal.png)

* Update the supporting libraries and SDKs
```sh
cd /home/linaro/Documents/aws-iot-device-sdk
./update
```

### DragonConnect

Connects and communicates with the Dragonboard&trade;. Written in C and integrating a 2-way MQTT channel through Amazon AWS, DragonConnect reads/writes to Ubuntu file handlers allowing control of on-board IO.

* Navigate to DragonConnect
```sh
cd /home/linaro/Documents/aws-iot-thing-sdk-dragonconnect-c/DragonBoard/
```

* Build the binary
```sh
make install
```

* Run DragonConnect as root, in order to access GPIO ports
```sh
sudo su
cd /home/linaro/Documents/aws-iot-thing-sdk-dragonconnect-c/DragonBoard/bin
./aws_demo
```

### DragonPulse

Utilizes NodeJs, MQTT protocol, and Amazon AWS services, to interact with Ubuntu shell commands. Extract performance and summary statistics to remotely monitor top CPU consumption, memory usage, network traffic, and disk space.

* Navigate to DragonPulse
```sh
cd /home/linaro/Documents/aws-iot-thing-sdk-dragonpulse-js/DragonBoard/
```

* Run as DragonPulse as root, in order to access iftop
```sh
sudo su
npm start
```