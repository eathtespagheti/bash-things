# Colors
Green='\033[0;32m'
BGreen='\033[1;32m'
Color_Off='\033[0m' # No Color

# Green echo
function gecho {
  echo -e "${Green}$1${Color_Off}"
}
function bgecho {
  echo -e "${BGreen}$1${Color_Off}"
}

# Enable bash_things
HOME_PATH='/home'
bgecho 'Enable bash_things in .bashrc'
echo >> $HOME_PATH/$USER/.bashrc
echo "# Customization" >> $HOME_PATH/$USER/.bashrc
echo "HOME_PATH='${HOME_PATH}'" >> $HOME_PATH/$USER/.bashrc
echo "source ${HOME_PATH}/$USER/.bash_things/loader.sh" >> $HOME_PATH/$USER/.bashrc

# Package update and upgrade
gecho 'Updating and upgrading packages'
sudo apt update
sudo apt upgrade -y

# Gnome 3 hacks
sh $HOME_PATH/$USER/.bash_things/firstrun/gnome3.sh

# Docker
sh $HOME_PATH/$USER/.bash_things/firstrun/docker.sh

# echo Done
bgecho 'Done!'
