# My zsh config for non-interactive shells
# Maël Valais <mael.valais@gmail.com> 2016
#

# I'm using omz
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"
export UPDATE_ZSH_DAYS=13
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
ZSH_HIGHLIGHT_MAXLENGTH=100

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=( ) # wd = command like cd
source $ZSH/oh-my-zsh.sh

# To hide the mvalais@mba-mael, I set the DEFAULT_USER var:
DEFAULT_USER=mvalais

#### Paths (from least important to most important) ####
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Library/TeX/texbin"
if [ -d '/Applications/Ipe.app' ]; then
  export PATH="$PATH:/Applications/Ipe.app/Contents/MacOS"
fi
#export PATH="/usr/local/opt/ghc@8.0/bin:$PATH"
#export MANPATH="/usr/local/Cellar/ghc@8.0/8.0.2/share/man:$MANPATH"
#export PATH="$HOME/Library/Haskell/bin:$PATH"
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH" # for 'stack'
fi
if [ -d "$HOME/bin" ]; then
  export PATH="$PATH:$HOME/bin"
fi

#export PATH=/Applications/MATLAB_R2016a.app/bin:$PATH
# An alias to matlab to be able to use it command-line
#alias matlab="matlab -nodisplay -nodesktop"

# Coreutils 5.93 (2005) are COMPLETELY outdated as it was the last version that
# shipped without the GPL version (or such). So I had to install coreutils
# using brew.
if /usr/local/opt/coreutils/libexec/gnubin/ls >2 2>/dev/null; then
  export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
  export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
fi

if [ -d "$HOME/.go" ]; then
  export GOPATH="$HOME/.go"
fi

alias aneto="ssh -Y aneto.math.ups-tlse.fr"
alias voyageur="ssh -Y voyageur.math.ups-tlse.fr"
alias shannon="ssh -Y shannon.math.ups-tlse.fr"
alias bolzano="ssh -Y bolzano.math.ups-tlse.fr"
alias leibniz="ssh -Y leibniz.math.ups-tlse.fr"
alias cauchy="ssh -Y cauchy.math.ups-tlse.fr"
alias euler="ssh -Y euler.math.ups-tlse.fr"
alias hamming="ssh -Y hamming.math.ups-tlse.fr"
alias bernoulli='ssh -Y bernoulli.math.univ-tlse3.fr'

alias imt=aneto
alias sasssh="ssh -Y vlm9212a@sasssh.univ-tlse3.fr" # -Y = fake X11 auth
alias ups=sasssh
alias sash="ssh -Y mvalais@sash.irit.fr"
alias bali="ssh -Y mvalais@bali.irit.fr"
alias c7ni="ssh -Y mvalais@c7ni.irit.fr"
alias irit=sash
alias polatouche="ssh -Y mvalais@polatouche"

alias plm="ssh -Y mvalais@ssh.math.cnrs.fr"

if which hub >/dev/null 2>&1; then
  alias git=hub
fi

if ls --version | grep coreutils >/dev/null 2>&1; then
  # If (GNU coreutils) ls is available
  alias ls="ls --color=auto"
elif ls -G >/dev/null 2>&1; then
  # If FreeBSD (=mac) ls is available
  alias ls="ls -G"
fi

alias tlm="tlmgr"
alias tlmonfly="texliveonfly"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
elif which code >/dev/null 2>&1 && [[ -n $VSCODE_PID ]]; then
  export EDITOR='code'
  export GIT_EDITOR='code --wait'
else
  export EDITOR='mvim'
  export GIT_EDITOR='vim'
fi


# OPAM initialization
if which opam >/dev/null 2>&1; then
  eval $(opam config env)
  export MANPATH=/usr/local/man:$(opam config var man):$MANPATH
fi

# I had to put it a the end because of README.md of
# https://github.com/zsh-users/zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh >/dev/null 2>&1
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh >/dev/null 2>&1
source /usr/local/share/zsh-navigation-tools/zsh-navigation-tools.plugin.zsh >/dev/null 2>&1

# Running zplug (the zsh package manager)
#export ZPLUG_HOME=/usr/local/opt/zplug
#source $ZPLUG_HOME/init.zsh

# Line added by iterm2 to enable the shell integration. But it messes with my
# oh_my_zsh theme (agnoster) so I had to disable it...
# The issue appears to be the prompt, showing a small ">" instead of " ~ "
# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

alias ls='ls --color=auto'

alias mlre="pbpaste | refmt --parse ml --print re --interface false | pbcopy"
alias reml="pbpaste | refmt --parse re --print ml --interface false | pbcopy"

export VAGRANT_HOME=/Volumes/Stockage/vagrant.d
export HOMEBREW_AUTO_UPDATE_SECS=$((60*60))

if [ -d "$HOME/.cargo" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi
