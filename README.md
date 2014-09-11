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
    echo 'welcome!' > ~/.sshrc.d/a.txt # the contents of ~/.sshrc.d will be copied to $SSHHOME/.sshrc.d
    echo 'cat $SSHHOME/.sshrc.d/a.txt' > ~/.sshrc
    sshrc me@myserver
    > welcome!

<h2>Vim Usage</h2>
    mkdir -p ~/.sshrc.d
    echo ':imap <special> jk <Esc>' > ~/.sshrc.d/vimrc
    echo 'VIM=$SSHHOME/.sshrc.d' > ~/.sshrc
    sshrc me@myserver
    vim # jk -> normal mode will work

<h2>Tmux Usage</h2>
    echo 'SHELL=$SSHHOME/bashsshrc;alias tmuxsshrc="tmux -L mytmuxserver";alias foo="echo I work with tmux, too"' > ~/.sshrc
    sshrc me@myserver
    tmuxsshrc
    foo
    > I work with tmux, too
    
Note the need for -L in the tmux alias. Tmux inherits its environment from the shell that starts tmux. You'll need to run your own server, which will load off the SHELL=bashsshrc executable. Be careful not to start a new regular tmux server without running `unset SHELL`, or your server's coinhabitants will get your configurations in their own shells.
