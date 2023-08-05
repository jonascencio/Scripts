#!/bin/bash

CONFIG=~/.ssh/config
SSH=~/.ssh

#Checking to see if the ~/.ssh directory exists
if [ -f "$SSH" ]; then
    echo "SSH Directory exists."
else
   [ mkdir -p $SSH ] ; echo "Creating the ~/.ssh directory for you, your welcome."
fi

echo "Digging into the directory"
cd ~/.ssh

echo "Checking if Config file is created"

if [ -f "$CONFIG" ]; then
    echo "Config file exists."
else
   touch config ; echo "Creating the config file for you, your welcome."
fi

echo "Opening the config file with default editor, now add your SSH Config code snippet and Save/Exit."
open -t config
exit 0