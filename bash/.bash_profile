export XDG_CONFIG_HOME=$HOME/.config

PERSONAL=$XDG_CONFIG_HOME/personal
# shellcheck source=/dev/null
source "$PERSONAL/env"

while read -r i; do
    # shellcheck source=/dev/null
    source "$i"
done < <(find -L "$PERSONAL")

# shellcheck source=/dev/null
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export GOPATH=$HOME/go
export DOTFILES=$HOME/.dotfiles

addToPathFront $HOME/.local/.npm-global/bin
addToPathFront $HOME/.local/n/bin/
addToPathFront $HOME/.local/go/bin
addToPathFront $GOPATH/bin

# Where should I put you?
bindkey -s ^f "tmux-sessionizer\n"

catr() {
    tail -n "+$1" $3 | head -n "$(($2 - $1 + 1))"
}

validateYaml() {
    python -c 'import yaml,sys;yaml.safe_load(sys.stdin)' <$1
}

goWork() {
    cp ~/.npm_work_rc ~/.npmrc
}

goPersonal() {
    cp ~/.npm_personal_rc ~/.npmrc
}

addThrottle() {
    local kbs="kbps"
    echo $kbs
    echo "About to throttle to $1 $kbs"
    echo "sudo tc qdisc add dev wlp59s0 handle 1: root htb default 11"
    echo "sudo tc class add dev wlp59s0 parent 1: classid 1:1 htb rate $1$kbs"
    echo "sudo tc class add dev wlp59s0 parent 1:1 classid 1:11 htb rate $1$kbs"
    sudo tc qdisc add dev wlp59s0 handle 1: root htb default 11
    sudo tc class add dev wlp59s0 parent 1: classid 1:1 htb rate $1$kbs
    sudo tc class add dev wlp59s0 parent 1:1 classid 1:11 htb rate $1$kbs
}

removeThrottle() {
    sudo tc qdisc del dev wlp59s0 root
}

cat1Line() {
    cat $1 | tr -d "\n"
}

ioloop() {
    FIFO=$(mktemp -u /tmp/ioloop_$$_XXXXXX) &&
        trap "rm -f $FIFO" EXIT &&
        mkfifo $FIFO &&
        (: <$FIFO &) && # avoid deadlock on opening pipe
        exec >$FIFO <$FIFO
}

eslintify() {
    cat $1 >/tmp/file_to_eslint
    npx eslint
}
