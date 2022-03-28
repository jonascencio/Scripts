#! /bin/bash

#Checks	the	availability of	the	JSS
echo "Checking JSS Connection..."
jamf checkJSSConnection

#if the above results does not contain "The JSS is available." then run (DOWLOADJSS) Download the CS Cert
if [[ String != "The JSS is available."]]; then
fi "$DOWNLOADJSS"

#(if no JSS connection) Download the required CS cert from the	JSS	and	adds cert as trusted to	System.keychain
DOWNLOADJSS= echo "Trusting JSS..." 
jamf trustJSS

#if the above results does contain "The JSS is available." then run (ENFORCEFW) Enforcing framework
if [[ String == "The JSS is available."]]; then
fi "$ENFORCEFW"

#This verb will enforce	the entire management framework	from the JSS including Scheduled Tasks,	the	Restricted Applications	and	Global	ManagementPreferences such as the Startup	Script	and	login/logout hooks.
ENFORCEFW= echo "Enforcing framework..."
jamf manage

#JAMF Inventory Update
echo "Running JAMF inventory update..."
jamf recon

#Remove jamf binary and components from machine
echo "Revoming JAMF Framework..."
jamf removeFramework

#Enroll machine taking an invitation from credentials rather than username/password
echo "Enrolling machine into JAMF..."
jamf enroll -noPolicy -invitation 32347644950677931216688333160783513749

#JAMF Inventory Update
echo "Running JAMF inventory update..."
jamf recon

#Checks for policies available
echo "Checking for available policies..."
jamf policy
