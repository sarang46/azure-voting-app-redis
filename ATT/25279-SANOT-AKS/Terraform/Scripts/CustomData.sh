#! /bin/bash
# This script is meant to be run in the Custom Data of each Azure Instance while it's booting. 
# Specifies custom data to supply to the machine. On Linux-based systems, this can be used as a cloud-init script.
# On other systems, this will be copied as a file on disk.

echo "hello init" > /var/log/custom-data.log
echo "hello ${name}" >> /var/log/custom-data.log
echo " ${destination}" >> /var/log/custom-data.log
echo " ${version}" >> /var/log/custom-data.log