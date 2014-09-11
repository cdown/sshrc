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
    
The contents of ~/.sshrc.d will be copied to $SSHHOME/.sshrc.d under /tmp. Try not to stuff too much junk into your ~/.sshrc.d. It'll slow down your login times, and if the folder contents are > 1MB, the server may start blocking your ssh attempts.

<h2>Vim Usage</h2>
    mkdir -p ~/.sshrc.d
    echo ':imap <special> jk <Esc>' > ~/.sshrc.d/vimrc
    echo 'VIM=$SSHHOME/.sshrc.d' > ~/.sshrc
    sshrc me@myserver
    vim # jk -> normal mode will work

<h2>Tmux Usage</h2>
    echo 'SHELL=$SSHHOME/bashsshrc;alias tmuxrussell="tmux -S /tmp/russelltmuxserver";alias foo="echo I work with tmux, too"' > ~/.sshrc
    sshrc me@myserver
    tmuxrussell
    foo
    > I work with tmux, too
    
Note the need for -L in the tmux alias. Tmux inherits its environment from the shell that starts tmux. You'll need to run your own server, which will load off the SHELL=bashsshrc executable. Be careful not to start the first shell on a regular tmux server (as long as `tmux ls` is nonempty you're okay) without running `unset SHELL`. Otherwise your server's coinhabitants will get your configurations in their own tmux shells.
