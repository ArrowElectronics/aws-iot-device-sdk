
# BeagleBone Black

Beaglebone Black development kit has the following contents:
* [Beaglebone Black development board](https://www.arrow.com/en/products/bb-bblk-000/circuitco)
* TiSense - Demo app written in NodeJS

![Image of Board](https://raw.githubusercontent.com/ArrowElectronics/aws-iot-device-sdk/master/images/beaglebone.jpg)

BeagleBone Black is a low-cost, community-supported development platform for developers and hobbyists. Boot Linux in under 10 seconds and get started on development in less than 5 minutes with just a single USB cable.

The developement kit can be setup in a matter of minutes by using a
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

Determine your board revision
Rev B = 2Gb
Rev C+ = 4 Gb

If you are running Rev B, we would suggest running the console OS version.

Find the correct installer:
http://elinux.org/Beagleboard:BeagleBoneBlack_Debian#Flashing_eMMC

**Definitions**
*flasher* - just flash to eMMC
*standalone* - can boot from the SD card

* Download the appropriate image
* Flash the image onto a SD card
* Insert the SD card into the Beaglebone, and apply power while holding down the S2 (top right) button, this should be followed by LEDs lighting in a sequential fashion

## Modify Network Configuration

* ssh into to the Beaglebone
```sh
$ ssh root@192.168.7.1
```

If your network has a default router address of 192.168.7.1, this will cause conflicts with connecting to the BeagleBone. 
You will need to add a nameserver so that the Beaglebone is able to connect to the internet
```sh
$ nano /etc/resolv.conf
//add the google dns nameserver
nameserver 8.8.8.8
```

Once the Beaglebone is able to connect to the internet, you should be able to perform system/application updates.

## Install Dependencies
```sh
$ apt-get install git
```

### Appendix

If all 4 LEDs flash at the same time at a regular interval, this is an indication that the flashing process failed

You can use resolveconf to make sure that if you had a network conflict, that it will bootup properly next time:
* Edit tail in /etc/resolvconf/resolv.conf.d
```sh
$ nano /etc/resolvconf/resolv.conf.d/tail
//add the google dns nameserver
nameserver 8.8.8.8
```

# License
This SDK is distributed under the
[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0),
see LICENSE.txt and NOTICE.txt for more information.
