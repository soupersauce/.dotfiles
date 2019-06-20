# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/souper/.oh-my-zsh"

################################################################################
# 						oh-my-zsh Settings
################################################################################
# Theme
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
source ~/.purepower

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
	debian
	themes
	zsh-autosuggestions
	vi-mode
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh


################################################################################
# 						Aliases
################################################################################
alias zshconfig="vim ~/.zshrc"
alias vimconfig="vim ~/.config/nvim/init.vim"
alias vimdiff="nvim -d"
alias fzvim='vim $(fzf)'
alias vim='nvim'
alias ls='ls --color=auto'

# tmux vim
alias tvimserver='NVIM_LISTEN_ADDRESS=tmuxEditor nvim'
alias tvim='nvr --remote-tab'
################################################################################
# 						Exports
################################################################################

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export NEOVIM_WIN_DIR=/mnt/c/tools/neovim/Neovim/
export GOPATH=$HOME/gocode
export EDITOR="/usr/bin/nvim"
export DISPLAY=localhost:0
# export MANPATH="/usr/local/man:$MANPATH"

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
psgrep() {
	ps -ef | grep "$1" | grep -v grep
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
	nnn "$@"

	if [ -f $NNN_TMPFILE  ]; then
		. $NNN_TMPFILE
		rm $NNN_TMPFILE
	fi
}

###############################################################################
# Source locals
###############################################################################
source ~/.ls_colors
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
autoload -Uz compinit
compinit
source ~/.exports.local.zsh
source ~/.aliases.local.zsh
source ~/.functions.local.zsh
