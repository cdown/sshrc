<h2>Installation</h2>

<h3>Ubuntu 12.04 or 14.04:</h3>
    
    sudo add-apt-repository ppa:russell-s-stewart/ppa
    sudo apt-get update
    sudo apt-get install sshrc


<h3>Everything else:</h3>
    wget https://raw.githubusercontent.com/Russell91/sshrc/master/sshrc
    chmod +x sshrc
    sudo mv sshrc /usr/local/bin #or anywhere else on your PATH


<h2>Basic Usage</h2>
    echo "alias foo='echo bar'" > ~/.sshrc
    sshrc me@myserver
    foo
    > bar

<h2>Advanced Usage</h2>
    mkdir -p ~/.sshrc.d
    echo 'welcome!' > ~/.sshrc.d/a.txt
    echo 'cat $SSHHOME/.sshrc.d/a.txt' > ~/.sshrc
    sshrc me@myserver
    > welcome!
