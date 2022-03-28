#!/bin/bash

#Purpose is to kill an specified running application and delete it from the machine

#Variables
appName="Caffeine"

#silently kill application
function kill_app() {
    #Initial kill
    if [[ $(pgrep -ix "$appName") ]]; then
        echo "Closing $appName"
        pkill "$appName"
        sleep 1
        
        #Verify application has been killed
        countUp=0
        while [[ $countUp -le 10 ]] ; do
            if [[ -z $(pgrep -ix pgrep "$appName") ]]; then
                echo "$appName successfully closed."
                break
            else
                let countUp=$countUp+1
                sleep 1
            fi
        done
        #Force Quit if attempt failed
        if [[ $(pgrep -x "$appName") ]]; then
            echo "$appName failed to quit - Force Quitting"
            pkill "$appName"
        fi
    fi
}

if [[ -z "${appName}" ]]; then
    echo "Application not running"
    exit 1
fi

#quit the app if running
kill_app "${appName}"

#Remove the app
echo "Removing application: $appName"

#Add .app to end if filename provided does not include file type e.g. "Caffeine"
if [[ ! $appName == *".app"* ]]; then
    appName=$appName".app"
fi

#Add standard path if none provided
if [[ ! $appName == *"/"* ]]; then
    appToDelete="/Applications/$appName"
else
    appToDelete="$appName"
fi

#Remove the application
/bin/rm -rf "${appToDelete}"
sleep 1

#Verify application is removed
echo "Verifying application has been removed..."
if [[ -f "${appToDelete}" ]]; then
    echo "Application removal failed"
else
    echo "Application removal successful"
fi
