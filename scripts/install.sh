#!/bin/bash

SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )

#detect the device that we are on
#this is a naive detection scheme
DEVICE_USER=""
BEAGLEBONE="beaglebone"
DRAGONBOARD="linaro-alip"

DEVICE_OS=$(uname -s)
DEVICE_TYPE=$(uname -n)
DEVICE_ARCH=$(uname -m)
DEVICE_VERSION=$(uname -r)

echo -e "Detected: $DEVICE_TYPE ($DEVICE_ARCH) running $DEVICE_OS $DEVICE_VERSION" 

if [ $DEVICE_TYPE == $BEAGLEBONE ] ; then
    DEVICE_USER="debian"
elif [ $DEVICE_TYPE == $DRAGONBOARD ] ; then
    DEVICE_USER="linaro"
else
    echo "could not detect device type"
fi

# were we able to detect the device type
if [ $DEVICE_USER != "" ]; then

    BASE_DEVICE_DIR="/home/$DEVICE_USER/Documents"
    
    AWS_IOT_DEVICE_DIR="aws-iot-device-sdk"
    ARROW_DIR="arrow"

    #ask for path to install to
    echo -e "Provide a directory to install in ($BASE_DEVICE_DIR is the default):"
    read pPath

    if [ "$pPath" == "" ] ; then
    echo "Using default path '$BASE_DEVICE_DIR'"
    else
    echo "Using custom path $pPath"
    BASE_DEVICE_DIR=$pPath
    fi

    if [ -d "$BASE_DEVICE_DIR" ]; then

    # update self/install self
    cd $SCRIPTPATH
    cd ..
    git pull
    git checkout master
    
    if [ $DEVICE_TYPE == $BEAGLEBONE ] ; then
        #run beaglebone related scripts
        ./beaglebone.sh
        
    elif [ $DEVICE_TYPE == $DRAGONBOARD ] ; then
        #run dragonboard related scripts
        ./dragonboard.sh
    fi
    
    #run amazon
    ./amazon.sh
    
    else
    echo "Please make sure the directory '$BASE_DEVICE_DIR' is accesible"
    fi
fi