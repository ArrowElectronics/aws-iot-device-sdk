
# BeagleBone Black

Arrow's DragonBoard&trade; 410c AWS IoT starter kit has the following contents:
* [Beaglebone Black development board](https://www.arrow.com/en/products/bb-bblk-000/circuitco)
* Power Supply 12V 2A
* DragonConnect - Demo App written in C
* DragonPulse - Demo app written in NodeJS

![Image of Board](https://raw.githubusercontent.com/ArrowElectronics/aws-iot-device-sdk/master/images/beaglebone.jpg)

BeagleBone Black is a low-cost, community-supported development platform for developers and hobbyists. Boot Linux in under 10 seconds and get started on development in less than 5 minutes with just a single USB cable.

![Image of IoT Stack](https://raw.githubusercontent.com/ArrowElectronics/aws-iot-device-sdk/master/images/iot_infographic.png)

The Starter Kit ecosystem can be setup in a matter of minutes by using a
standard monitor and keyboard, connecting to the internet with the
Beaglebone, and running the demos.

Combining the unique features of Beaglebone with Amazon Web Services
creates an integrated ecosystem for bringing any project online.

# Getting Started

### Requirements
* Standard monitor
* mini HDMI to HDMI cable to connect Beaglebone to monitor
* USB Keyboard
* USB Mouse
* Bluetooth dongle
* Ethernet internet connection

## Re-image to Debian

## Modify Network Configuration


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
