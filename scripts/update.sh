#!/bin/bash

# we assume that this repo is already present on the device

BASE_DRAGONBOARD_DIR="/home/linaro/Documents"
AWS_IOT_DEVICE_DIR="aws-iot-device-sdk"
DRAGONPULSE_DIR="aws-iot-thing-sdk-dragonpulse-js"
DRAGONCONNECT_DIR="aws-iot-thing-sdk-dragonconnect-c"
AWS_IOT_JS_DIR="aws-iot-device-sdk-js"
AWS_IOT_C_DIR="aws-iot-device-sdk-embedded-C"

# update self
cd $BASE_DRAGONBOARD_DIR/$AWS_IOT_DEVICE_DIR
git pull

# navigate to the base directory
cd $BASE_DRAGONBOARD_DIR

# install/update dragonpulse demo
if [ -d "$DRAGONPULSE_DIR" ]; then
	git pull
else
	git clone git@github.com:ArrowElectronics/aws-iot-thing-sdk-dragonpulse-js.git
fi

# install/update dragonconnect demo
if [ -d "$DRAGONCONNECT_DIR" ]; then
	git pull
else
	git clone git@github.com:ArrowElectronics/aws-iot-thing-sdk-dragonconnect-c.git
fi

# install/update aws iot sdk javascript
if [ -d "$AWS_IOT_JS_DIR" ]; then
	git pull
else
	git clone git@github.com:aws/aws-iot-device-sdk-js.git
fi

# install/update aws iot sdk embedded c
if [ -d "$AWS_IOT_C_DIR" ]; then
	git pull
else
	git clone git@github.com:aws/aws-iot-device-sdk-embedded-C.git
fi