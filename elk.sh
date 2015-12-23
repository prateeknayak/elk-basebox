#!/bin/bash


echo "Installing elk (elastic kibana logstash nginx)"

sh ./installs/java.sh 2&1> javainstall.log

echo "Java install process finished check javainstall.log for details"

echo "Starting elastic search install"


