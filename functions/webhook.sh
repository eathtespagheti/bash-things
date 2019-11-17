#!/usr/bin/env bash

HOME_PATH=$(getent passwd $USER | cut -d: -f6)

function checkKey() {
    if [ -z "$1" ]; then # Check if the KEY parameter exist
        echo "No KEY provided, using the default one..."
        source $HOME_PATH/.webhook/config
    fi
    if [ -z "$KEY" ]; then # Check if the KEY parameter exist
        echo "No KEY configured in the configuration file"
        echo "Write your KEY as a bash variable inside" $HOME_PATH"/.webhook/config"
        exit 3
    fi
}

if [ -z "$1" ]; then # Check turn status
    echo "No action provided"
    echo "Usage: webhook.sh [0/1] [DEVICE] [KEY]"
    echo "If no key it's provided the default will be used"
    exit 1
elif [ -z "$2" ]; then # Check if the DEVICE parameter exist
    SUBMISSION_NUMBER=$1
    echo "No DEVICE provided"
    echo "Usage: webhook.sh [0/1] [DEVICE] [KEY]"
    echo "If no key it's provided the default will be used"
    exit 2
elif [ -z "$3" ]; then # Check if the KEY parameter exist
    SUBMISSION_NUMBER=$1
    checkKey $3
    COMMAND=$1
    DEVICE=$2
else
    COMMAND=$1
    DEVICE=$2
    KEY=$3
fi

if [ "$COMMAND" = "1" ]; then
    COMMAND="on"
elif [ "$COMMAND" = "0" ]; then
    COMMAND="off"
else
    echo "Wrong command provided"
    echo "Valid values are: 0 ; 1"
    exit 1
fi

MESSAGE="turn_${COMMAND}_${DEVICE}"
REQUEST="https://maker.ifttt.com/trigger/${MESSAGE}/with/key/${KEY}"
FILENAME="${HOME_PATH}/.webhook/requestResult"

echo "Turning $COMMAND $DEVICE with key $KEY"

wget -O $FILENAME $REQUEST >/dev/null 2>&1 # Make web request and suppress output
requestResult=$(cat $FILENAME)             # Print request result on a variable
rm $FILENAME                               # Remove request result

if [ -z "$requestResult" ]; then # if request result it's empty
    echo "ERROR firing the event: Invalid KEY"
    exit 4
fi
echo $requestResult
exit 0
