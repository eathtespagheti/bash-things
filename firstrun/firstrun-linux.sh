# Enable bash_things
echo 'Enable bash_things in .bashrc...'
HOME_PATH='/home'
echo >> $HOME_PATH/$USER/.bashrc
echo "# Customization" >> $HOME_PATH/$USER/.bashrc
echo "HOME_PATH='${HOME_PATH}'" >> $HOME_PATH/$USER/.bashrc
echo "source ${HOME_PATH}/$USER/.bash_things/loader.sh" >> $HOME_PATH/$USER/.bashrc

# Package update and upgrade
echo 'Updating and upgrading packages...'
sudo apt update
sudo apt upgrade -y

# Gnome 3 hacks
.${HOME_PATH}/$USER/.bash_things/firstrun/gnome3.sh

# echo Done
echo 'Done!'
