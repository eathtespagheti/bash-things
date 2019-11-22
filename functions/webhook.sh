#!/usr/bin/env bash

HOME_PATH=$(getent passwd $USER | cut -d: -f6)

function generateDelayRequest() { # Return the request for a delayed call, input parameters are message, mins, key
    REQUEST="http://lab.grapeot.me/ifttt/delay?event=$1&t=$2&key=$3"
}

function generateRequest() {
    REQUEST="https://maker.ifttt.com/trigger/$1/with/key/$2"
}

function generateMessage() {
    MESSAGE="turn_$1_$2"
}

function checkKey() {
    source $HOME_PATH/.webhook/config # Sourcing the key file
    if [ -z "$KEY" ]; then # Check if the KEY parameter exist
        echo "No KEY configured in the configuration file"
        echo "Write your KEY as a bash variable inside" $HOME_PATH"/.webhook/config"
        exit 3
    fi
}

function makeWebRequest() { # Make the web request
    FILENAME="${HOME_PATH}/.webhook/requestResult"

    wget -O $FILENAME $REQUEST >/dev/null 2>&1 # Make web request and suppress output
    requestResult=$(cat $FILENAME)             # Print request result on a variable
    rm $FILENAME                               # Remove request result

    if [ -z "$requestResult" ]; then # if request result it's empty
        echo "ERROR firing the event: Invalid KEY"
        exit 4
    fi
    echo $requestResult
    exit 0
}

if [ -z "$1" ]; then # Check turn status
    echo "No action provided"
    echo "Usage: webhook.sh [0/1] [DEVICE] optional[DELAY]"
    exit 1
elif [ -z "$2" ]; then # Check if the DEVICE parameter exist
    echo "No DEVICE provided"
    echo "Usage: webhook.sh [0/1] [DEVICE] optional[DELAY]"
    exit 2
fi
checkKey

# MESSAGE GENERATION
COMMAND=$1
DEVICE=$2
if [ "$COMMAND" = "1" ]; then
    COMMAND="on"
elif [ "$COMMAND" = "0" ]; then
    COMMAND="off"
else
    echo "Wrong command provided"
    echo "Valid values are: 0 ; 1"
    exit 1
fi
generateMessage $COMMAND $DEVICE

if [ -z "$3" ]; then # Check if delay parameter exist
    generateRequest $MESSAGE $KEY
else
    generateDelayRequest $MESSAGE $3 $KEY
fi

echo "Turning $COMMAND $DEVICE with key $KEY"
makeWebRequest
