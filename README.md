<h2>Installation</h2>

<h3>Ubuntu (12.04 and 14.04 only):</h3>
    
    $ sudo add-apt-repository ppa:russell-s-stewart/ppa
    $ sudo apt-get update
    $ sudo apt-get install sshrc


<h3>Everything else:</h3>
    $ wget https://raw.githubusercontent.com/Russell91/sshrc/master/sshrc
    $ chmod +x sshrc
    $ sudo mv sshrc /usr/local/bin #or anywhere else on your PATH

<h2>Usage</h2>

sshrc works just like ssh, but it also sources ~/.sshrc after logging in remotely.

    $ echo "echo welcome" > ~/.sshrc
    $ sshrc me@myserver
    welcome

    $ echo "alias ..='cd ..'" > ~/.sshrc
    $ sshrc me@myserver
    $ type ..
    .. is aliased to `cd ..'

Your most import configuration files (e.g. vim, inputrc) may not be bash scripts. Put them in ~/.sshrc.d and sshrc will copy them to the /tmp directory after login. You can find them on the sever at $SSHHOME/.sshrc.d

    $ mkdir -p ~/.sshrc.d
    $ echo ':imap <special> jk <Esc>' > ~/.sshrc.d/vimrc
    $ echo 'VIM=$SSHHOME/.sshrc.d' > ~/.sshrc
    $ sshrc me@myserver
    $ vim # jk -> normal mode will work
    
Putting too much data in ~/.sshrc.d will slow down your login times. If the folder contents are > 1MB, the server may start blocking your sshrc attempts.

If you use tmux frequently, you can make sshrc work there as well.

    $ echo 'SHELL=$SSHHOME/bashsshrc
      alias tmuxrussell="tmux -S /tmp/russelltmuxserver"
      alias foo="echo I work with tmux, too"' > ~/.sshrc
    $ sshrc me@myserver
    $ tmuxrussell
    $ foo
    I work with tmux, too
    
Note the need for -S in the tmux alias. Tmux inherits its environment from the shell that starts tmux. You'll need to run your own server, which will load off the SHELL=bashsshrc executable. Be careful not to start the first shell on a regular tmux server (as long as `tmux ls` is nonempty you're okay) without running `unset SHELL`. Otherwise your server's coinhabitants will get your configurations in their own tmux shells.
