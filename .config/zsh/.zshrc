eval "$(zoxide init zsh)"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ ! -a "$ZDOTDIR/.antidote/antidote.zsh" ]]; then
  git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
fi
# first, run this from an interactive zsh terminal session:

source ${ZDOTDIR:-~}/.antidote/antidote.zsh

# Set general Zsh options needed for config.
setopt extended_glob

export FZF_BASE="~/.fzf/bin/"
# export FZF_DEFAULT_COMMAND=
DISABLE_FZF_AUTO_COMPLETION="false"
DISABLE_FZF_KEY_BINDINGS="false"
# bindkey -v

zstyle ':antidote:bundle' use-friendly-names 'yes'
#
# Lazy-load functions
#

# Autoload functions directory and its subdirs.
for funcdir in $ZDOTDIR/functions $ZDOTDIR/functions/*(N/); do
  fpath=($funcdir $fpath)
  autoload -Uz $fpath[1]/*(.:t)
done
unset funcdir

#
# Pre-antidote
#
function zvm_config() {
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
  # ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_ZLE
  ZVM_ESCAPE_KEYTIMEOUT=0
}
# The plugin will auto execute this zvm_after_init function
# Be sure to set any supplemental completions directories before compinit is run.
fpath=(${ZDOTDIR}/completions(-/FN) $fpath)

#
# antidote
#

# Set the name of the static .zsh plugins file antidote will generate.
zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins.zsh

# Lazy-load antidote.
fpath+=(${ZDOTDIR:-~}/.antidote)
autoload -Uz $fpath[-1]/antidote

# Generate static file in a subshell when .zsh_plugins.txt is updated.
if [[ ! $zsh_plugins -nt ${zsh_plugins:r}.txt ]]; then
  (antidote bundle <${zsh_plugins:r}.txt >|$zsh_plugins)
fi

# Source your static plugins file.
source $zsh_plugins
source $ZDOTDIR/functions.zsh


antidote load

function zvm_after_init() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
  if [[ -n "$key_info" ]]; then
    # vi
    bindkey -M viins "$key_info[Control]F" vi-forward-word
    bindkey -M viins "$key_info[Control]E" vi-add-eol
  fi

}
export TMUX_CONFIG=$HOME/.tmux.conf
export CARGO_HOME=$HOME/.cargo


# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# vim: ft=zsh sw=2 ts=2 et
