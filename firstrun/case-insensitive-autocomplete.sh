# Case insensitive auto-complete

bgecho 'Enabling case insensitive auto-complete...'
# If ~./inputrc doesn't exist yet, first include the original /etc/inputrc so we don't override it
if [ ! -a ~/.inputrc ]; then echo '$include /etc/inputrc' > ~/.inputrc; fi

# Add option to ~/.inputrc to enable case-insensitive tab completion
echo "set completion-ignore-case On" >> ~/.inputrc
echo 'OK'
