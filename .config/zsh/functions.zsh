function peek() { tmux split-window -p 33 $EDITOR $@ || exit; }

function sshretry() {
    false
    while [ $? -ne 0 ]; do
        ssh "$@" || (sleep 1;false)
    done
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# mkir and cd to new directory
function mkcd {
    mkdir -p "$1" && cd "$1"
}

function backup () {
    for file in "$@"; do
        local new=${file}.$(date '+%F_%R')
        while [[ -f %new ]]; do
            new+="~";
        done;
        printf "copying '%s' to '%s'\n" "$file" "$new";
        \cp -ip "$file" "$new";
    done
}

function maclookup() {
    curl "https://api.maclookup.app/v2/macs/$1" | jq
}

function reqfile {
    echo "$1" >> reqs.txt
}

function linkfile {
    echo "$1" >> Link.txt
}

function runscheme () {
    scheme --quiet < "$1"
}

# vim: ft=zsh sw=2 ts=2 et
