#!/bin/bash
set -e

# SSHRC
# https://github.com/cdown/sshrc/
# sshrc works just like ssh, but it also sources the ~/.sshrc on your local computer after logging in remotely.

# Install sshrc
wget https://raw.githubusercontent.com/cdown/sshrc/master/sshrc
chmod +x sshrc
sudo mv sshrc /usr/local/bin #or anywhere else on your PATH

# Make a link to your local .bashrc file that sshrc will copy at connection at /tmp/.<YOUR_USERNAME>.sshrc...
mkdir ~/.sshrc.d
ln -s ~/.bashrc ~/.sshrc.d

echo -e "echo \"Your custom .bashrc file has been copied and sourced\"
source /tmp/.<YOUR_USERNAME>.sshrc.*/.sshrc.d/.bashrc" > ~/.sshrc

# Connection
# sshrc $USER host_ip