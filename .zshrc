# My zsh config for non-interactive shells
# Maël Valais <mael.valais@gmail.com> 2016
#

# I'm using omz
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"
export UPDATE_ZSH_DAYS=13
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=( ) # wd = command like cd
source $ZSH/oh-my-zsh.sh

# To hide the mvalais@mba-mael, I set the DEFAULT_USER var:
DEFAULT_USER=mvalais

#### My configuration ####

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Library/TeX/texbin"
export PATH="$PATH:$HOME/bin"
#export PATH="$PATH:/Applications/Ipe.app/Contents/MacOS/"
export MANPATH=/usr/local/man:$(opam config var man):$MANPATH

export PATH=/Applications/MATLAB_R2016a.app/bin:$PATH
# An alias to matlab to be able to use it command-line
alias matlab="matlab -nodisplay -nodesktop"

# Coreutils 5.93 (2005) are COMPLETELY outdated as it was the last version that
# shipped without the GPL version (or such). So I had to install coreutils
# using brew.
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH

alias aneto="ssh -Y mvalais@aneto.math.ups-tlse.fr"
alias imt=aneto
alias sasssh="ssh -Y vlm9212a@sasssh.univ-tlse3.fr" # -Y = fake X11 auth
alias ups=sasssh
alias sash="ssh -Y mvalais@sash.irit.fr"
alias bali="ssh -Y mvalais@bali.irit.fr"
alias irit=sash

alias plm="ssh -Y mvalais@ssh.math.cnrs.fr"

alias git=hub
#alias ls="ls -G" # for FreeBSD (=mac) bash
alias ls="ls --color=auto" # for GNU Bash/GNU ls

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi


# OPAM initialization
eval `opam config env`

# I had to put it a the end because of README.md of
# https://github.com/zsh-users/zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-navigation-tools/zsh-navigation-tools.plugin.zsh

# Running zplug (the zsh package manager)
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# Line added by iterm2 to enable the shell integration. But it messes with my
# oh_my_zsh theme (agnoster) so I had to disable it...
# The issue appears to be the prompt, showing a small ">" instead of " ~ "
# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

alias ls='ls --color=auto'
