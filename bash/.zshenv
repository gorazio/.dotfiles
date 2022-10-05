export XDG_CONFIG_HOME=$HOME/.config

PERSONAL=$XDG_CONFIG_HOME/personal

source "$PERSONAL/env"

while read -r i; do
    source "$i"
done < <(find -L "$PERSONAL" -maxdepth 1 -mindepth 1)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

addToPathFront $GOPATH/bin

eval "$(direnv hook bash)"

HISTSIZE=10000
HISTFILESIZE=200000
