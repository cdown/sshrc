#!/usr/bin/env bash
function sshrc() {
    local SSHHOME=${SSHHOME:=~}
    if [ -f $SSHHOME/.sshrc ]; then
        local files=.sshrc
        if [ -d $SSHHOME/.sshrc.d ]; then
            files="$files .sshrc.d"
        fi
        SIZE=$(tar cfz - -h -C $SSHHOME $files | wc -c)
        if [ $SIZE -gt 65536 ]; then
            echo >&2 $'.sshrc.d and .sshrc files must be less than 64kb\ncurrent size: '$SIZE' bytes'
            exit 1
        fi
        if [ -z "$CMDARG" -a ! -e ~/.sshrc.d/.hushlogin ]; then
            WELCOME_MSG="
                if [ ! -e ~/.hushlogin ]; then
                    if [ -e /etc/motd ]; then cat /etc/motd; fi
                    if [ -e /etc/update-motd.d ]; then run-parts /etc/update-motd.d/ 2>/dev/null; fi
                    last -F \$USER 2>/dev/null | grep -v 'still logged in' | head -n1 | awk '{print \"Last login:\",\$4,\$5,\$6,\$7,\$8,\"from\",\$3;}'
                fi
                "
        else
            WELCOME_MSG=""
        fi
        ssh -t "$DOMAIN" $SSHARGS "
            command -v openssl >/dev/null 2>&1 || { echo >&2 \"sshrc requires openssl to be installed on the server, but it's not. Aborting.\"; exit 1; }
            $WELCOME_MSG
            export SSHHOME=\$(mktemp -d -t .$(whoami).sshrc.XXXX)
            export SSHRCCLEANUP=\$SSHHOME
            trap \"rm -rf \$SSHRCCLEANUP; exit\" 0
            echo $'"$(cat "$0" | openssl enc -base64)"' | tr -s ' ' $'\n' | openssl enc -base64 -d > \$SSHHOME/sshrc
            chmod +x \$SSHHOME/sshrc

            echo $'"$( cat << 'EOF' | openssl enc -base64
                if [ -r /etc/profile ]; then source /etc/profile; fi
                if [ -r ~/.bash_profile ]; then source ~/.bash_profile
                elif [ -r ~/.bash_login ]; then source ~/.bash_login
                elif [ -r ~/.profile ]; then source ~/.profile
                fi
                export PATH=$PATH:$SSHHOME
                source $SSHHOME/.sshrc;
EOF
                )"' | tr -s ' ' $'\n' | openssl enc -base64 -d > \$SSHHOME/sshrc.bashrc

            echo $'"$( cat << 'EOF' | openssl enc -base64
#!/usr/bin/env bash
                exec bash --rcfile <(echo '
                [ -r /etc/profile ] && source /etc/profile
                if [ -r ~/.bash_profile ]; then source ~/.bash_profile
                elif [ -r ~/.bash_login ]; then source ~/.bash_login
                elif [ -r ~/.profile ]; then source ~/.profile
                fi
                source '$SSHHOME'/.sshrc;
                export PATH=$PATH:'$SSHHOME'
                ') "$@"
EOF
                )"' | tr -s ' ' $'\n' | openssl enc -base64 -d > \$SSHHOME/bashsshrc
            chmod +x \$SSHHOME/bashsshrc

            echo $'"$(tar czf - -h -C $SSHHOME $files | openssl enc -base64)"' | tr -s ' ' $'\n' | openssl enc -base64 -d | tar mxzf - -C \$SSHHOME
            export SSHHOME=\$SSHHOME
            echo \"$CMDARG\" >> \$SSHHOME/sshrc.bashrc
            bash --rcfile \$SSHHOME/sshrc.bashrc
            "
    else
        echo "No such file: $SSHHOME/.sshrc" >&2
        exit 1
    fi
}

function sshrc_parse() {
  while [[ -n $1 ]]; do
    case $1 in
      -b | -c | -D | -E | -e | -F | -I | -i | -L | -l | -m | -O | -o | -p | -Q | -R | -S | -W | -w )
        SSHARGS="$SSHARGS $1 $2"; shift ;;
      -* )
        SSHARGS="$SSHARGS $1" ;;
      *)
        if [ -z "$DOMAIN" ]; then
         DOMAIN="$1"
        else
          local SEMICOLON=$([[ "$@" = *[![:space:]]* ]] && echo '; ')
          CMDARG="$@$SEMICOLON exit"
          return;
        fi
        ;;
    esac
    shift
  done
  if [ -z $DOMAIN ]; then
    ssh $SSHARGS; exit 1;
  fi
}

command -v openssl >/dev/null 2>&1 || { echo >&2 "sshrc requires openssl to be installed locally, but it's not. Aborting."; exit 1; }
sshrc_parse "$@"
sshrc
