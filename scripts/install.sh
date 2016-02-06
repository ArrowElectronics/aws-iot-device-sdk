#!/bin/bash

SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )

# we assume that nodejs, build-essentials is installed already...
# in this script we will install and update all the repositories to a certain version

BASE_DRAGONBOARD_DIR="/home/linaro/Documents"
AWS_IOT_DEVICE_DIR="aws-iot-device-sdk"

ARROW_DIR="arrow"
DRAGONPULSE="aws-iot-dragonpulse-js"
DRAGONCONNECT="aws-iot-dragonconnect-c"
DEFAULT_PULSE_VERSION="1.1.0"
DEFAULT_CONNECT_VERSION="1.1.0"

AMAZON_DIR="amazon"
AWS_IOT_JS="aws-iot-device-sdk-js"
AWS_IOT_C="aws-iot-device-sdk-embedded-C"
DEFAULT_AWS_VERSION_JS="v1.0.10"
DEFAULT_AWS_VERSION_C="v1.0.1"

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
  echo -e "DragonPulse Version to install ($DEFAULT_PULSE_VERSION is the default):"
  read pVersion

  if [ "$pVersion" != "" ] ; then
    DEFAULT_PULSE_VERSION=$pVersion
  fi

  echo -e "DragonConnect Version to install ($DEFAULT_CONNECT_VERSION is the default):"
  read pVersion

  if [ "$pVersion" != "" ] ; then
    DEFAULT_CONNECT_VERSION=$pVersion
  fi

  echo "***Installing Arrow DragonBoard Examples version $DEFAULT_PULSE_VERSION (dragonpulse) and $DEFAULT_CONNECT_VERSION (dragonconnect)"

  #ask for aws js version to install
  echo -e "Amazon AWS JS Version to install ($DEFAULT_AWS_VERSION_JS is the default):"
  read pVersion

  if [ "$aVersion" != "" ] ; then
    DEFAULT_AWS_VERSION_JS=$aVersion
  fi

  #ask for aws c version to install
  echo -e "Amazon AWS C Version to install ($DEFAULT_AWS_VERSION_C is the default):"
  read pVersion

  if [ "$aVersion" != "" ] ; then
    DEFAULT_AWS_VERSION_C=$aVersion
  fi

  echo "***Installing Amazon AWS libraries version $DEFAULT_AWS_VERSION_JS (js) and $DEFAULT_AWS_VERSION_C (c)"

  # update self/install self
  cd $SCRIPTPATH
  cd ..
  git pull
  git checkout master

  # navigate to the base directory
  cd $BASE_DRAGONBOARD_DIR
  
  #-------------------
  # install/update dragonpulse demo
  #-------------------
  if [ ! -d "$ARROW_DIR/$DRAGONPULSE" ]; then
    mkdir -p $ARROW_DIR
    cd $ARROW_DIR
    git clone https://github.com/ArrowElectronics/$DRAGONPULSE.git $DRAGONPULSE
  fi

  cd $ARROW_DIR/$DRAGONPULSE
  git pull
  git checkout tags/$DEFAULT_VERSION

  #reset the path
  cd $BASE_DRAGONBOARD_DIR

  #-------------------
  # install/update dragonconnect demo
  #-------------------
  if [ ! -d "$ARROW_DIR/$DRAGONCONNECT" ]; then
    mkdir -p $ARROW_DIR
    cd $ARROW_DIR
    git clone https://github.com/ArrowElectronics/$DRAGONCONNECT.git $DRAGONCONNECT
  fi

  cd $ARROW_DIR/$DRAGONCONNECT
  git pull
  git checkout tags/$DEFAULT_VERSION

  #reset the path
  cd $BASE_DRAGONBOARD_DIR

  #-------------------
  # install/update aws iot sdk javascript
  #-------------------
  if [ ! -d "$AMAZON_DIR/$AWS_IOT_JS" ]; then
    mkdir -p $AMAZON_DIR
    cd $AMAZON_DIR
    git clone https://github.com/aws/$AWS_IOT_JS.git $AWS_IOT_JS
  fi

  cd $AMAZON_DIR/$AWS_IOT_JS
  git pull
  git checkout tags/$DEFAULT_AWS_VERSION_JS

  #reset the path
  cd $BASE_DRAGONBOARD_DIR

  #-------------------
  # install/update aws iot sdk embedded c
  #-------------------
  if [ ! -d "$AMAZON_DIR/$AWS_IOT_C" ]; then
    mkdir -p $AMAZON_DIR
    cd $AMAZON_DIR
    git clone https://github.com/aws/$AWS_IOT_C.git $AWS_IOT_C  
  fi

  cd $AMAZON_DIR/$AWS_IOT_C
  git pull
  git checkout tags/$DEFAULT_AWS_VERSION_C

  #reset the path
  cd $BASE_DRAGONBOARD_DIR

  echo "Installing Amazon AWS command line client (aws-cli)"

  if [ ! -d "$AMAZON_DIR/tmp" ]; then
    mkdir -p $AMAZON_DIR/tmp
  fi

  cd $AMAZON_DIR/tmp
  curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
  #install aws command line
  # extract the bundle
  unzip awscli-bundle.zip
  # install the bundle
  sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
  #configure aws
  aws configure

else
  echo "Please make sure the directory '$BASE_DRAGONBOARD_DIR' is accesible"
fi
