#!/bin/bash



AMAZON_DIR="amazon"
AWS_IOT_JS="aws-iot-device-sdk-js"
AWS_IOT_C="aws-iot-device-sdk-embedded-C"
DEFAULT_AWS_VERSION_JS="v1.0.10"
DEFAULT_AWS_VERSION_C="v1.0.1"

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

#reset the path
cd $BASE_DEVICE_DIR

#-------------------
# install/update aws iot sdk javascript
#-------------------
if [ ! -d "$AMAZON_DIR/$AWS_IOT_JS" ]; then
mkdir -p $AMAZON_DIR
cd $AMAZON_DIR
git clone https://github.com/aws/$AWS_IOT_JS.git $AWS_IOT_JS
fi

cd $BASE_DEVICE_DIR/$AMAZON_DIR/$AWS_IOT_JS
git pull
git checkout tags/$DEFAULT_AWS_VERSION_JS

#reset the path
cd $BASE_DEVICE_DIR

#-------------------
# install/update aws iot sdk embedded c
#-------------------
if [ ! -d "$AMAZON_DIR/$AWS_IOT_C" ]; then
mkdir -p $AMAZON_DIR
cd $AMAZON_DIR
git clone https://github.com/aws/$AWS_IOT_C.git $AWS_IOT_C  
fi

cd $BASE_DEVICE_DIR/$AMAZON_DIR/$AWS_IOT_C
git pull
git checkout tags/$DEFAULT_AWS_VERSION_C

#reset the path
cd $BASE_DEVICE_DIR

echo "Installing Amazon AWS command line client (aws-cli)"

if [ ! -d "$AMAZON_DIR/tmp" ]; then
mkdir -p $AMAZON_DIR/tmp
fi

cd $BASE_DEVICE_DIR/$AMAZON_DIR/tmp

curl -O https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py 
sudo pip install awscli

#configure aws
aws configure