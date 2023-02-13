. "$HOME/.cargo/env"
export CARGO_HOME=$HOME/.cargo/
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-${HOME}/.config}
export ZDOTDIR=${ZDOTDIR:-${XDG_CONFIG_HOME}/zsh}

if [ -e "/usr/bin/nvim" ]|| [ -e "/usr/local/bin/nvim" ] ; then
  export "EDITOR=nvim"
else
  export "EDITOR=vim"
fi
