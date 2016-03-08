#!/bin/bash

DRAGONPULSE="aws-iot-dragonpulse-js"
DRAGONCONNECT="aws-iot-dragonconnect-c"
DEFAULT_PULSE_VERSION="1.1.1"
DEFAULT_CONNECT_VERSION="1.1.1"

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

# navigate to the base directory
cd $BASE_DEVICE_DIR

#-------------------
# install/update dragonpulse demo
#-------------------
if [ ! -d "$ARROW_DIR/$DRAGONPULSE" ]; then
mkdir -p $ARROW_DIR
cd $ARROW_DIR
git clone https://github.com/ArrowElectronics/$DRAGONPULSE.git $DRAGONPULSE
fi

cd $BASE_DEVICE_DIR/$ARROW_DIR/$DRAGONPULSE
git pull
git checkout tags/$DEFAULT_PULSE_VERSION

#reset the path
cd $BASE_DEVICE_DIR

#-------------------
# install/update dragonconnect demo
#-------------------
if [ ! -d "$ARROW_DIR/$DRAGONCONNECT" ]; then
mkdir -p $ARROW_DIR
cd $ARROW_DIR
git clone https://github.com/ArrowElectronics/$DRAGONCONNECT.git $DRAGONCONNECT
fi

cd $BASE_DEVICE_DIR/$ARROW_DIR/$DRAGONCONNECT
git pull
git checkout tags/$DEFAULT_CONNECT_VERSION
