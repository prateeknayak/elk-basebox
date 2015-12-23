#!/bin/bash

# lets get java 8 shall we.

echo debconf shared/accepted-oracle-license-v1-1 select true | \
sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | \
sudo debconf-set-selections

# adding webupdate team ppa
sudo add-apt-repository -y ppa:webupd8team/java

# update apt
sudo apt-get update

# install the thingy
sudo apt-get -y install oracle-java8-installer

# install set defaults
sudo apt-get -y install oracle-java8-set-defaults