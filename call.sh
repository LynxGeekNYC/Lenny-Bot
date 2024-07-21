#!/bin/bash

# Define variables
ASTERISK_HOST="localhost"
ASTERISK_PORT="5038"
ASTERISK_USER="admin"
ASTERISK_PASSWORD="your_ami_password"
CALLERID="YourCallerID"  # Replace with a suitable CallerID
EXTENSION="talk"
CONTEXT="Lenny"
PRIORITY="1"
CHANNEL="PJSIP/your_sip_channel"  # Replace with your SIP channel
DESTINATION="$1"  # The phone number to call, passed as a script argument

# Asterisk Manager Interface command
AMI_COMMAND="Action: Originate
Channel: $CHANNEL/$DESTINATION
Context: $CONTEXT
Exten: $EXTENSION
Priority: $PRIORITY
CallerID: $CALLERID
Timeout: 30000"

# Send the command to Asterisk
(
  echo "Action: Login"
  echo "Username: $ASTERISK_USER"
  echo "Secret: $ASTERISK_PASSWORD"
  echo ""
  echo "$AMI_COMMAND"
  echo ""
  echo "Action: Logoff"
) | nc $ASTERISK_HOST $ASTERISK_PORT
