<pre>
Installation

    # Ubuntu 12.04 or 14.04:

    sudo add-apt-repository ppa:russell-s-stewart/ppa
    sudo apt-get update
    sudo apt-get install sshrc


    # Everything else:

    wget https://raw.githubusercontent.com/Russell91/sshrc/master/sshrc
    chmod +x sshrc
    sudo mv sshrc /usr/local/bin #or anywhere else on your PATH


Usage
    echo "alias foo='echo bar'" > ~/.sshrc
    sshrc me@myserver

</pre>
