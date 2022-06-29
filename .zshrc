# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# # Initialization code that may require console input (password prompts, [y/n]
# # confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"  ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:~/.emacs.d/bin/:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

################################################################################
# 						oh-my-zsh Settings
################################################################################
# Theme
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Case sensitive completion
# CASE_SENSITIVE="true"

# Hyphen-insensitive completion (casesensitive must be off)
# HYPHEN_INSENSITIVE="true"

# Auto update oh-my-zsh after:
export UPDATE_ZSH_DAYS=7

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Untracked files dirty in version-control
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

DISABLE_LS_COLORS="false"

################################################################################
# 						Plugins
################################################################################
plugins=(
	git
	colored-man-pages
	colorize
	command-not-found
	history
	tmux
	ubuntu
	themes
	zsh-autosuggestions
	vi-mode
	alias-finder
	zsh-syntax-highlighting # This Plugin should be loaded last
)

source $ZSH/oh-my-zsh.sh
autoload -U compinit && compinit

################################################################################
# 						Aliases
################################################################################
alias zshconfig="vim ~/.zshrc"
alias vimconfig="vim ~/.config/nvim/init.vim"
alias vimdiff="nvim -d"
alias fzvim='vim $(fzf)'
alias vim='nvim'
alias ls='ls --color=auto'
alias gfar='git fetch && git reset --hard origin'
alias info='info --vi-keys'
alias lynx='lynx --vikeys'

# tmux vim
alias tvimserver='NVIM_LISTEN_ADDRESS=tmuxEditor nvim'
alias tvim='nvr --remote-tab'


################################################################################
# 						Exports
################################################################################

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export NEOVIM_WIN_DIR=/mnt/c/tools/neovim/Neovim/
export GOPATH=$HOME/go
export EDITOR="/usr/bin/nvim"
export PATH="$PATH:$GOPATH/bin"
export EDITOR="/usr/bin/nvim"
export KEYTIMEOUT=1
export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git/**"'
export TERM=tmux-256color
export PREMUX=$TERM

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
################################################################################
# 						Zsh  Options
################################################################################

setopt extendedglob
unsetopt nomatch
setopt histignorespace
bindkey -v

################################################################################
# 						Zsh  Keybinds
################################################################################

bindkey '^ ' autosuggest-accept

################################################################################
# 						Config for VTE Terminals
################################################################################
if [[ $TERM == xterm-termite  ]]; then
	  . /etc/profile.d/vte.sh
	    __vte_osc7
fi
################################################################################
# 						Functions
################################################################################

peek() { tmux split-window -p 33 $EDITOR $@ || exit; }

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

backup () {
	for file in "$@"; do
		local new=${file}.$(date '+%F_%R')
		while [[ -f %new ]]; do
			new+="~";
		done;
		printf "copying '%s' to '%s'\n" "$file" "$new";
		\cp -ip "$file" "$new";
	done
}

# greps ps for arguemnt ignores grep
maclookup() {
	curl "https://api.maclookup.app/v2/macs/$1" | jq
}

function reqfile {
	echo "$1" >> reqs.txt
}

function linkfile {
	echo "$1" >> Link.txt
}

export NNN_TMPFILE="/tmp/nnn"

n()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

runscheme () {
	scheme --quiet < "$1"
}

xhamdl () {
    youtube-dl "$1" &
}
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

###############################################################################
# Source locals
###############################################################################
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
autoload -Uz compinit 
compinit
source ~/.exports.local.zsh || touch ~/.exports.local.zsh
source ~/.aliases.local.zsh || touch ~/.aliases.local.zsh
source ~/.functions.local.zsh || touch ~/.functions.local.zsh
