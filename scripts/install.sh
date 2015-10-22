#!/bin/bash

# we assume we are sudo already

BASE_DRAGONBOARD_DIR="/home/linaro/Documents"
IS_FORCE="n"
IS_INSTALL="n"

if [ "$1" == "-f" ];then
    IS_FORCE="y"
else 
    IS_FORCE="n"
fi

cd $BASE_DRAGONBOARD_DIR

if [ "$IS_FORCE"=="y" ];then
    IS_INSTALL="y"
    echo "forcing NodeJS install"
else
    CURRENT_NODE_VERSION = `node --version | sed 's/^.*[^0-9]\([0-9]*\.[0-9]*\.[0-9]*\).*$/\1/'`
    #do a version check
    if [ "$CURRENT_NODE_VERSION" == "" ] ; then
        IS_INSTALL="y"
    else
        echo "NodeJS v$CURRENT_NODE_VERSION exists"
    fi
fi

if [ "$IS_INSTALL"=="y" ] ; then
   if [ ! -d "tmp" ]; then
    mkdir -p tmp
   fi
   
   #relative to base
   cd tmp
   # currently node is not in the sources for apt-get, or this would be easier
   # we'll pull directly from the node site and install into /home/linaro/share
   # we need the arm64 version
   # https://nodejs.org/dist/latest/node-v4.2.1-linux-arm64.tar.gz
   NODE_LIB_ARCHIVE_FILE=`wget -q https://nodejs.org/dist/latest/ -O - | grep arm64.tar.gz | awk -F\" '{print $2}'`
   NODE_VERSION=`echo $NODE_LIB_ARCHIVE_FILE | sed 's/^.*[^0-9]\([0-9]*\.[0-9]*\.[0-9]*\).*$/\1/'`

   echo "installing NodeJS $NODE_VERSION..."
  
   wget https://nodejs.org/dist/latest/$NODE_LIB_ARCHIVE_FILE
   tar -xf $NODE_LIB_ARCHIVE_FILE
   
   if [ ! -d /home/linaro/share ];then
    mkdir -p /home/linaro/share
   fi
 
   mv node-v$NODE_VERSION-linux-arm64 /home/linaro/share
   
   #check if there are current symlinks
   if [ -a /usr/local/bin/node ];then
    rm /usr/local/bin/node
   fi
   
   if [ -a /usr/local/bin/npm ];then
    rm /usr/local/bin/npm
   fi
   
   #create the symlinks
   ln -s /home/linaro/share/node-v$NODE_VERSION-linux-arm64/bin/node /usr/local/bin/node
   ln -s /home/linaro/share/node-v$NODE_VERSION-linux-arm64/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm
   
   #fix the permissions
   chown -R linaro:linaro /home/linaro/share
   chmod 777 /usr/local/bin/node
   chmod 777 /usr/local/bin/npm
   
   #cleanup
   cd $BASE_DRAGONBOARD_DIR
   rm -Rf tmp
fi

# install other things
apt-get update
apt-get upgrade
apt-get install gcc g++ python2.7 build-essential openssl libssl-dev nano iftop 