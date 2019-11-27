# bash-things

A collection of .bashrc setups and bash functions/scripts I often use for configuring and managing my machines (for both Arch Linux and macOS)

## Installing

Just run one of these two commands from your home directory, the first one use **curl** and the othe **wget**. The script will automatically find your Operating System and install the right things.

*curl*
```bash
curl -o- https://gitlab.com/Fabi0Z/bash-things/raw/master/install.sh | bash
```

*wget*
```bash
wget -qO- https://gitlab.com/Fabi0Z/bash-things/raw/master/install.sh | bash
```

## Updating

You can update bash-things with the update script found in `functions/bash-things-update.sh` or just using the alias `bash-things-update`

## webhook
It's a bash script for toggling on and off smart devices via IFTTT webhooks, to use it you need to configure some webhooks in your IFTTT
account using this scheme:

For every device create two Webhooks, one for turning on
```
IF:
    webhooks.receiveWebRequest
        EventName: turn_on_{{DEVICE}}
THEN:
    yourSmartDeviceManager
        TurnOn: {{DEVICE}}
```
and one for turning off
```
IF:
    webhooks.receiveWebRequest
        EventName: turn_off_{{DEVICE}}
THEN:
    yourSmartDeviceManager
        TurnOff: {{DEVICE}}
```

then launch the script with these args:
``` bash
./webhook.sh [0/1] [DEVICE] optional[DELAY]
```

there's a preconfigured alias for this script named `webhook` in `loader.sh`

## trueline
I'm using trueline by petobens on GitHub, for setting it up check [his project](https://github.com/petobens/trueline)
