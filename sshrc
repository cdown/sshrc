#!/usr/bin/env bash
function sshrc() {
    local SSHHOME=${SSHHOME:=~}
    if [ -f $SSHHOME/.sshrc ]; then
        local files=.sshrc
        if [ -d $SSHHOME/.sshrc.d ]; then
            files="$files .sshrc.d"
        fi
        ssh -t "$@" "
            if [ -e /etc/motd ]; then cat /etc/motd; fi
            export SSHHOME=\$(mktemp -d -t .$(whoami).sshrc.XXXX)
            export SSHRCCLEANUP=\$SSHHOME
            trap \"rm -rf \$SSHRCCLEANUP; exit\" 0
            echo $'"$(cat "$0" | xxd -p)"' | xxd -p -r > \$SSHHOME/sshrc
            chmod +x \$SSHHOME/sshrc
            echo $'"$( cat << 'EOF' | xxd -p
#!/usr/bin/env bash
exec bash --rcfile <(echo '
if [ -e /etc/bash.bashrc ]; then source /etc/bash.bashrc; fi
if [ -e ~/.bashrc ]; then source ~/.bashrc; fi
source '$SSHHOME'/.sshrc;
export PATH=$PATH:'$SSHHOME'
') "$@"
EOF
)"' | xxd -p -r > \$SSHHOME/bashsshrc
            chmod +x \$SSHHOME/bashsshrc
            echo $'"$(tar cz -h -C $SSHHOME $files | xxd -p)"' | xxd -p -r | tar mxz -C \$SSHHOME
            export SSHHOME=\$SSHHOME
            \$SSHHOME/bashsshrc
            rm -rf \$SSHRCCLEANUP
            "
    else
        echo "No such file: $SSHHOME/.sshrc"
    fi
}
if [ $1 ]; then
    sshrc $@
else
    ssh
fi
