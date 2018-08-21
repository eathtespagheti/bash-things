# Fix GNOME 3 workspaces
echo 'Fixing GNOME 3 workspaces...'
gsettings set org.gnome.shell.overrides workspaces-only-on-primary false
