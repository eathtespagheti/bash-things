echo
gecho '--- DOCKER INSTALL ---'

gecho 'Installing requirements'
sudo apt install apt-transport-https ca-certificates curl software-properties-common

gecho 'Adding PGP key'
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

gecho 'Adding PPA'
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic test"

gecho 'Updating APT'
sudo apt update

gecho 'Installing Docker CE'
sudo apt install docker-ce -y

echo
bgecho 'Enabling Docker as a non root user'
gecho 'Adding docker group'
sudo groupadd docker
gecho "Adding ${USER} to the docker group"
sudo usermod -aG docker $USER

echo
gecho 'Enable Docker at startup'
sudo systemctl enable docker
