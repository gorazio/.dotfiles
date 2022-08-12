export XDG_CONFIG_HOME=$HOME/.config

PERSONAL=$XDG_CONFIG_HOME/personal

source "$PERSONAL/env"

while read -r i; do
    source "$i"
done < <(find -L "$PERSONAL")

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

addToPathFront $GOPATH/bin
export BW_SESSION='session'
