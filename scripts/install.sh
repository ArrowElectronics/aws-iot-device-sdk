#!/bin/bash

SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )

# we assume that nodejs, build-essentials is installed already...
# in this script we will install and update all the repositories to a certain version

BASE_DRAGONBOARD_DIR="/home/linaro/Documents"
AWS_IOT_DEVICE_DIR="aws-iot-device-sdk"
DRAGONPULSE_DIR="aws-iot-dragonpulse-js"
DRAGONCONNECT_DIR="aws-iot-dragonconnect-c"
AWS_IOT_JS_DIR="aws-iot-device-sdk-js"
AWS_IOT_C_DIR="aws-iot-device-sdk-embedded-C"
DEFAULT_VERSION="v1.0.0"
DEFAULT_AWS_VERSION="v1.0.7"

#ask for path to install to
echo -e "Provide a directory to install in (/home/linaro/Documents is the default):"
read pPath

if [ "$pPath" == "" ] ; then
  echo "Using default path '/home/linaro/Documents'"
else
  echo "Using custom path $pPath"
  BASE_DRAGONBOARD_DIR=$pPath
fi

if [ -d "$BASE_DRAGONBOARD_DIR" ]; then

  #ask for arrow dragonboard version to install
  echo -e "DragonBoard Version to install ($DEFAULT_VERSION is the default):"
  read pVersion

  if [ "$pVersion" != "" ] ; then
    DEFAULT_VERSION=$pVersion
  fi

  echo "Installing Arrow DragonBoard version $DEFAULT_VERSION"

  #ask for aws version to install
  echo -e "Amazon AWS Version to install ($DEFAULT_AWS_VERSION is the default):"
  read pVersion

  if [ "$aVersion" != "" ] ; then
    DEFAULT_AWS_VERSION=$aVersion
  fi

  echo "Installing Amazon AWS version $DEFAULT_AWS_VERSION"

  # update self/install self
  cd $SCRIPTPATH
  cd ..
  git pull
  git checkout tags/$DEFAULT_VERSION

  # navigate to the base directory
  cd $BASE_DRAGONBOARD_DIR

  # install/update dragonpulse demo
  if [ -d "$DRAGONPULSE_DIR" ]; then
    git pull
    git checkout tags/$DEFAULT_VERSION
  else
    git clone https://github.com/ArrowElectronics/$DRAGONPULSE_DIR.git
  fi

  # install/update dragonconnect demo
  if [ -d "$DRAGONCONNECT_DIR" ]; then
    git pull
    git checkout tags/$DEFAULT_VERSION
  else
    git clone https://github.com/ArrowElectronics/$DRAGONCONNECT_DIR.git
  fi

  # install/update aws iot sdk javascript
  if [ -d "$AWS_IOT_JS_DIR" ]; then
    git pull
    git checkout tags/$DEFAULT_AWS_VERSION
  else
    git clone https://github.com/aws/$AWS_IOT_JS_DIR.git
  fi

  # install/update aws iot sdk embedded c
  if [ -d "$AWS_IOT_C_DIR" ]; then
    git pull
    git checkout tags/$DEFAULT_AWS_VERSION
  else
    git clone https://github.com/aws/$AWS_IOT_C_DIR.git
  fi
else
  echo "Please make sure the directory '$BASE_DRAGONBOARD_DIR' is accesible"
fi
