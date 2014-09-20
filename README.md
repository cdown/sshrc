<h2>Usage</h2>

sshrc works just like ssh, but it also sources the ~/.sshrc on your local computer after logging in remotely.

    $ echo "echo welcome" > ~/.sshrc
    $ sshrc me@myserver
    welcome

    $ echo "alias ..='cd ..'" > ~/.sshrc
    $ sshrc me@myserver
    $ type ..
    .. is aliased to `cd ..'

You can use this to set environment variables, define functions, and run post-login commands. It's that simple, and it won't impact other users on the server - even if they use sshrc too. This makes sshrc very useful if you share a server with multiple users and can't edit the server's ~/.bashrc without affecting them, or if you have several servers that you don't want to configure independently.

<h2>Installation</h2>

<h3>Ubuntu (12.04 and 14.04 only):</h3>
    
    $ sudo add-apt-repository ppa:russell-s-stewart/ppa
    $ sudo apt-get update
    $ sudo apt-get install sshrc


<h3>Everything else:</h3>
    $ wget https://raw.githubusercontent.com/Russell91/sshrc/master/sshrc
    $ chmod +x sshrc
    $ sudo mv sshrc /usr/local/bin #or anywhere else on your PATH

<h2>Advanced configuration</h2>

Your most import configuration files (e.g. vim, inputrc) may not be bash scripts. Put them in ~/.sshrc.d and sshrc will copy them to a (guaranteed) unique folder in the server's /tmp directory after login. You can find them at $SSHHOME/.sshrc.d

You can usually tell programs to load their configuration from the $SSHHOME/.sshrc.d directory by setting the right environment variables. For example, vim uses the VIM environment variable.

    $ mkdir -p ~/.sshrc.d
    $ echo ':imap <special> jk <Esc>' > ~/.sshrc.d/vimrc
    $ echo 'VIM=$SSHHOME/.sshrc.d' > ~/.sshrc
    $ sshrc me@myserver
    $ vim # jk -> normal mode will work
    
Putting too much data in ~/.sshrc.d will slow down your login times. If the folder contents are > 1MB, the server may start blocking your sshrc attempts.

If you use tmux frequently, you can make sshrc work there as well.

    $ echo 'SHELL=$SSHHOME/bashsshrc
      alias tmux="tmux -S /tmp/russelltmuxserver"
      alias foo="echo I work with tmux, too"' > ~/.sshrc
    $ sshrc me@myserver
    $ tmuxrussell
    $ foo
    I work with tmux, too

After the SHELL variable is set, any new tmux server will load your configurations. The -S option will start a separate tmux server at /tmp/russelltmuxserver. Don't try to access the vanilla tmux server when your SHELL environment variable is set: if the server isn't already running, other users will get your configurations with their own sessions.
