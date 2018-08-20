# Enable bash_things
echo 'Enable bash_things in .bashrc...'
HOME_PATH='/home'
echo >> $HOME_PATH/$USER/.bashrc
echo "# Customization" >> $HOME_PATH/$USER/.bashrc
echo "HOME_PATH='${HOME_PATH}'" >> $HOME_PATH/$USER/.bashrc
echo "source ${HOME_PATH}/$USER/.bash_things/loader.sh" >> $HOME_PATH/$USER/.bashrc


# Fix GNOME 3 workspaces
echo 'Fixing GNOME 3 workspaces...'
gsettings set org.gnome.shell.overrides workspaces-only-on-primary false

# echo Done
echo 'Done!'
