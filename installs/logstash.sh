#!/bin/bash

# lets get logstash installed

# adding repo to source list
echo 'deb http://packages.elasticsearch.org/logstash/2.1/debian stable main' | sudo tee /etc/apt/sources.list.d/logstash.list

# update apt-get
sudo apt-get update

# install logstash
sudo apt-get install logstash
