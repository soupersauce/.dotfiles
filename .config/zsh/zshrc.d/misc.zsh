#
# misc - Set general Zsh config options here, or change plugin settings.
#

#
# Options
#

# Undo options from plugins
setopt NO_BEEP       # Be quiet!
setopt NO_HIST_BEEP  # Be quiet!

#
# OMZ
#

#
# Zsh-Utils
#

# The belek/zsh-utils completion plugin also introduces compstyles. Let's use that!
(( ! $+functions[compstyle_zshzoo_setup] )) || compstyle_zshzoo_setup

#
# Z
#

ZSHZ_DATA=${XDG_DATA_HOME:=$HOME/.local/share}/z/data
