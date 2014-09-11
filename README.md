<h2>Installation</h2>

<h3>Ubuntu 12.04 or 14.04:</h3>
    
    sudo add-apt-repository ppa:russell-s-stewart/ppa
    sudo apt-get update
    sudo apt-get install sshrc


<h3>Everything else:</h3>
    wget https://raw.githubusercontent.com/Russell91/sshrc/master/sshrc
    chmod +x sshrc
    sudo mv sshrc /usr/local/bin #or anywhere else on your PATH


<h1>Usage</h1>

    echo "alias foo='echo bar'" > ~/.sshrc
    sshrc me@myserver

