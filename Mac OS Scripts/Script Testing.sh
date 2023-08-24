#!/bin/bash

#Variables:

#Create a desktop folder
mkdir ~/Desktop/compliance-check-$(date +%FT%T)

#Create text file within folder
touch ~/Desktop/compliance-check-$(date +%FT%T)/Compliance Report.txt

#Gather System Information
system_profiler SPSoftwareDataType SPHardwareDataType
