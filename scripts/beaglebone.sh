#!/bin/bash

apt-get update
apt-get upgrade

apt-get install locales resolvconf bluetooth bluez curl unzip

#clean up
apt-get autoremove

cd $BASE_DEVICE_DIR

#LTS
#https://nodejs.org/dist/latest-v4.x/
#Stable
#https://nodejs.org/dist/latest/

#we will install the LTS version to keep it simple

NODE_LIB_ARCHIVE_FILE=`wget -q https://nodejs.org/dist/latest-v4.x/ -O - | grep $DEVICE_ARCH.tar.xz | awk -F\" '{print $2}'`
NODE_VERSION=`echo $NODE_LIB_ARCHIVE_FILE | sed 's/^.*[^0-9]\([0-9]*\.[0-9]*\.[0-9]*\).*$/\1/'`

echo "installing NodeJS $NODE_VERSION..."
 
if [ ! -d tmp ] ; then	
    mkdir tmp
fi

cd tmp
wget https://nodejs.org/dist/latest-v4.x/$NODE_LIB_ARCHIVE_FILE

if [ ! -d $BASE_DEVICE_DIR/share ] ; then		
 mkdir -p $BASE_DEVICE_DIR/share		
fi		

mv node-v$NODE_VERSION-linux-$DEVICE_ARCH $BASE_DEVICE_DIR/share

if [ -a /usr/local/bin/node ];then		
    rm /usr/local/bin/node		
fi		
 		
if [ -a /usr/local/bin/npm ];then		
    rm /usr/local/bin/npm		
fi		
		
#create the symlinks		
ln -s $BASE_DEVICE_DIR/share/node-v$NODE_VERSION-linux-$DEVICE_ARCH/bin/node /usr/local/bin/node		
ln -s $$BASE_DEVICE_DIR/share/node-v$NODE_VERSION-linux-$DEVICE_ARCH/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm	
#fix the permissions		
chown -R $DEVICE_USER:$DEVICE_USER $BASE_DEVICE_DIR/share		
chmod 777 /usr/local/bin/node		
chmod 777 /usr/local/bin/npm

cd $BASE_DEVICE_DIR		
rm -Rf tmp