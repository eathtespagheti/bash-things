# bash-things

A collection of .bashrc setups and bash functions/scripts I often use for configuring and managing my machines (for both Arch Linux and macOS)

## Installing

Just run one of these two commands from your home directory, the first one use **curl** and the othe **wget**. The script will automatically find your Operating System and install the right things.

*curl*
```bash
curl -o- https://gitlab.com/eathtespagheti/bash-things/raw/master/install.sh | bash
```

*wget*
```bash
wget -qO- https://gitlab.com/eathtespagheti/bash-things/raw/master/install.sh | bash
```

## Updating

You can update bash-things with the update script found in `scripts/bash-things-update.sh` or just using the alias `bash-things-update`

## webhook
It's a bash script for toggling on and off smart devices via IFTTT webhooks, to use it check the [project on gitlab](https://gitlab.com/eathtespagheti/webhook.git).
There's a preconfigured alias for this script named `webhook` in `modules/alias.sh`

## trueline
I'm using trueline by petobens on GitHub, for setting it up check [his project](https://github.com/petobens/trueline)

## pure
I'm using pure by @sindresorhus on GitHub, for setting it up check [his project](https://github.com/sindresorhus/pure)
