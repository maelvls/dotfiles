# My zsh config for non-interactive shells
# Maël Valais <mael.valais@gmail.com> 2016
#

UPDATE_ZSH_DAYS=13
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
ZSH_HIGHLIGHT_MAXLENGTH=200

# On linux, add brew to path
[ ! -d "$HOME/.linuxbrew" ] || export PATH="$HOME/.linuxbrew/bin:$PATH"
[ ! -d "/home/linuxbrew/.linuxbrew" ] || export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

source $(brew --prefix)/share/antigen/antigen.zsh
# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
#antigen bundle git
#antigen bundle jsontools

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle psprint/zsh-navigation-tools
#antigen bundle zsh-users/zsh-history-substring-search

# Load the theme (sobol, ....)
antigen theme agnoster

# Tell Antigen that you're done.
antigen apply

# (agnoster theme) To hide the mvalais@mba-mael, set DEFAULT_USER=mvalais
DEFAULT_USER=mvalais

#### Paths (from least important to most important) ####
#export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"
export PATH="$PATH:/Library/TeX/texbin"
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
if which /usr/local/opt/coreutils/libexec/gnubin/ls >/dev/null 2>&1; then
  export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
  export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
fi

# Gnu-sed (brew install gnu-sed)
if which /usr/local/opt/gnu-sed/libexec/gnubin/sed >/dev/null 2>&1; then
  export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
  export MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"
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
alias osirim="ssh -Y mvalais@osirim-slurm.irit.fr"
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
export GIT_EDITOR='vim' # by default
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
elif which code >/dev/null 2>&1; then
  export EDITOR='code'
  # If we are inside vscode, git commit will open in vscode
  if [[ -n $VSCODE_PID ]]; then
    export GIT_EDITOR='code --wait'
  fi
else
  which mvim >/dev/null 2>&1 && export EDITOR='mvim'
fi

# OPAM initialization
if which opam >/dev/null 2>&1; then
  eval $(opam config env)
  export MANPATH=/usr/local/man:$(opam config var man):$MANPATH
fi

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
# For using code-insiders instead of code:
# ln -sf /usr/local/bin/code-insiders /usr/local/bin/code

# A small function for pretty-printting a json from stdin
# From https://stackoverflow.com/questions/352098/how-can-i-pretty-print-json-in-unix-shell-script
alias to_j="ruby -e \"require 'json';puts JSON.pretty_generate(JSON.parse(STDIN.read))\""
# with gem install awesome_print
alias to_j="ruby -e \"require 'json';require 'awesome_print';ap JSON.parse(STDIN.read)\""

# A small fonction to 'uri-fy' any text from stdin
function uri() {
  cat | od -An -tx1 | tr ' ' % | xargs printf "%s"
}

