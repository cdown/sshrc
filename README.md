<h2>Installation</h2>

<h3>Ubuntu (12.04 and 14.04 only):</h3>
    
    $ sudo add-apt-repository ppa:russell-s-stewart/ppa
    $ sudo apt-get update
    $ sudo apt-get install sshrc


<h3>Everything else:</h3>
    $ wget https://raw.githubusercontent.com/Russell91/sshrc/master/sshrc
    $ chmod +x sshrc
    $ sudo mv sshrc /usr/local/bin #or anywhere else on your PATH


<h2>Basic Usage</h2>

    $ echo "echo welcome" > ~/.sshrc
    $ sshrc me@myserver
    welcome

    $ echo "alias ..='cd ..'" > ~/.sshrc
    $ sshrc me@myserver
    $ type ..
    .. is aliased to `cd ..'

Just specify whatever bash commands you would like to run after sshing into your server in ~/.sshrc. The tool will copy the file to a temp folder on the server, and source that file after starting bash. Other users of the server will not be affected.

Your most import configuration files (e.g. vim, inputrc) may not be bash scripts. Sshrc will let you load these configurations into your ssh session. Just put the config files into a ~/.sshrc.d directory. They will be copied to the server and can be accessed at `$SSHHOME/.sshrc.d`.

    $ mkdir -p ~/.sshrc.d
    $ echo 'some data' > ~/.sshrc.d/data.txt
    $ echo 'cat $SSHHOME/.sshrc.d/data.txt' > ~/.sshrc
    $ sshrc me@myserver
    some data
    
The contents of ~/.sshrc.d will be copied to $SSHHOME/.sshrc.d under /tmp. Try not to stuff too much junk into your ~/.sshrc.d. It'll slow down your login times, and if the folder contents are > 1MB, the server may start blocking your ssh attempts.

<h2>Vim Usage</h2>
    $ mkdir -p ~/.sshrc.d
    $ echo ':imap <special> jk <Esc>' > ~/.sshrc.d/vimrc
    $ echo 'VIM=$SSHHOME/.sshrc.d' > ~/.sshrc
    $ sshrc me@myserver
    $ vim # jk -> normal mode will work

<h2>Tmux Usage</h2>
    $ echo 'SHELL=$SSHHOME/bashsshrc
      alias tmuxrussell="tmux -S /tmp/russelltmuxserver"
      alias foo="echo I work with tmux, too"' > ~/.sshrc
    $ sshrc me@myserver
    $ tmuxrussell
    $ foo
    I work with tmux, too
    
Note the need for -S in the tmux alias. Tmux inherits its environment from the shell that starts tmux. You'll need to run your own server, which will load off the SHELL=bashsshrc executable. Be careful not to start the first shell on a regular tmux server (as long as `tmux ls` is nonempty you're okay) without running `unset SHELL`. Otherwise your server's coinhabitants will get your configurations in their own tmux shells.
