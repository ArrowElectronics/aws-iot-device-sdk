#!/bin/bash

TISENSE="aws-iot-tisense-js"
DEFAULT_SENSE_VERSION="1.0.0"

#ask for arrow dragonboard version to install
echo -e "TiSense Version to install ($DEFAULT_SENSE_VERSION is the default):"
read pVersion

if [ "$pVersion" != "" ] ; then
DEFAULT_SENSE_VERSION=$pVersion
fi

echo "***Configuring system with additional dependencies..."

#we need a higher version of nodejs
sudo apt-get remove node nodejs npm

sudo apt-get update
sudo apt-get upgrade

sudo apt-get install locales resolvconf bluetooth bluez curl unzip python virtualenv default-jre

#remove some stuff to free up room
sudo apt-get remove oxygen-icon-theme
 
#clean up
sudo apt-get autoremove

cd $BASE_DEVICE_DIR


#check to see if online, if not online we cant do anything
wget -q --tries=10 --timeout=20 --spider http://google.com
if [[ $? -eq 0 ]]; then
    #online, continue
else
    echo -e "No internet connection, please follow the reconnect instructions before continuning..."
    exit 1
fi


#see if node exists.
#TODO (:gtam)

#LTS
#https://nodejs.org/dist/latest-v4.x/
#Stable
#https://nodejs.org/dist/latest/

#we will install the LTS version to keep it simple

NODE_LIB_ARCHIVE_FILE=`wget -q https://nodejs.org/dist/latest-v4.x/ -O - | grep $DEVICE_ARCH.tar.xz | awk -F\" '{print $2}'`
NODE_VERSION=`echo $NODE_LIB_ARCHIVE_FILE | sed 's/^.*[^0-9]\([0-9]*\.[0-9]*\.[0-9]*\).*$/\1/'`

echo "***Installing NodeJS $NODE_VERSION..."
 
if [ ! -d tmp ] ; then	
    mkdir tmp
fi

cd tmp
wget https://nodejs.org/dist/latest-v4.x/$NODE_LIB_ARCHIVE_FILE

tar -xf $NODE_LIB_ARCHIVE_FILE

if [ ! -d $BASE_DEVICE_DIR/share ] ; then		
 mkdir -p $BASE_DEVICE_DIR/share		
fi		

mv node-v$NODE_VERSION-linux-$DEVICE_ARCH $BASE_DEVICE_DIR/share

if [ -f /usr/local/bin/node ]; then		
    sudo rm -Rf /usr/local/bin/node		
fi		
 		
if [ -f /usr/local/bin/npm ]; then		
    sudo rm -Rf /usr/local/bin/npm		
fi		
		
#create the symlinks		
sudo ln -s $BASE_DEVICE_DIR/share/node-v$NODE_VERSION-linux-$DEVICE_ARCH/bin/node /usr/local/bin/node		
sudo ln -s $BASE_DEVICE_DIR/share/node-v$NODE_VERSION-linux-$DEVICE_ARCH/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm	
#fix the permissions		
sudo chown -R $DEVICE_USER:$DEVICE_USER $BASE_DEVICE_DIR/share		
sudo chmod 777 /usr/local/bin/node		
sudo chmod 777 /usr/local/bin/npm

cd $BASE_DEVICE_DIR		
rm -Rf tmp

npm install -g grunt-cli

echo "***Installing Arrow TiSense Example version $DEFAULT_SENSE_VERSION (tisense)"

# navigate to the base directory
cd $BASE_DEVICE_DIR

#-------------------
# install/update tisense demo
#-------------------
if [ ! -d "$ARROW_DIR/$TISENSE" ]; then
    mkdir -p $ARROW_DIR
    cd $ARROW_DIR
    git clone https://github.com/ArrowElectronics/$TISENSE.git $TISENSE
fi

cd $BASE_DEVICE_DIR/$ARROW_DIR/$TISENSE
git pull
git checkout tags/$DEFAULT_SENSE_VERSION

#reset the path
cd $BASE_DEVICE_DIR