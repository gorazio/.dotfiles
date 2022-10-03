export XDG_CONFIG_HOME=$HOME/.config

PERSONAL=$XDG_CONFIG_HOME/personal

source "$PERSONAL/env"

while read -r i; do
    source "$i"
done < <(find -L "$PERSONAL" -maxdepth 1 -mindepth 1)

# Point the SSH_AUTH_SOCK to the one handled by gpg-agent
if [ -S $(gpgconf --list-dirs agent-ssh-socket) ]; then
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
else
    echo "$(gpgconf --list-dirs agent-ssh-socket) doesn't exist. Is gpg-agent running ?"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

addToPathFront $GOPATH/bin

eval "$(direnv hook bash)"

HISTSIZE=10000
HISTFILESIZE=200000
