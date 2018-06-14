# My zsh config for non-interactive shells
# Maël Valais <mael.valais@gmail.com> 2016
#
# Shortcuts:
#   ctrl+G for 'z-jump' + fzf
#   ctrl+R for reverse-i-search history (fzf)
#   ctrl+T for fuzzy finder (fzf)

UPDATE_ZSH_DAYS=13
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
ZSH_HIGHLIGHT_MAXLENGTH=300

# On linux, add brew to path
[ ! -d "$HOME/.linuxbrew" ] || export PATH="$HOME/.linuxbrew/bin:$PATH"
[ ! -d "/home/linuxbrew/.linuxbrew" ] || export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"


# For 'cargo install --git https://github.com/xcambar/purs'
#function zle-line-init zle-keymap-select {
#  PROMPT=`purs prompt -k "$KEYMAP" -r "$?"`
#  zle reset-prompt
#}
#zle -N zle-line-init
#zle -N zle-keymap-select
#autoload -Uz add-zsh-hook
#function _prompt_purs_precmd() {
#  purs precmd --git-detailed
#}
#add-zsh-hook precmd _prompt_purs_precmd

# make search up and down work, so partially type and hit up/down to find relevant stuff
#bindkey '^[[A' up-line-or-search; bindkey '^[[B' down-line-or-search




# Search antigen
if which brew >/dev/null 2>&1; then
    source $(brew --prefix)/share/antigen/antigen.zsh
elif [ -f /usr/share/zsh/share/antigen/antigen.zsh ]; then
    source /usr/share/zsh/share/antigen/antigen.zsh
else
    echo -e "\033[93mantigen:\033[0m antigen.zsh not installed?"
fi

antigen use oh-my-zsh

antigen bundle gitfast
#antigen bundle git
#antigen bundle jsontools
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle psprint/zsh-navigation-tools
#antigen bundle zsh-users/zsh-history-substring-search

# Z and fzf
antigen bundle rupa/z
antigen bundle andrewferrier/fzf-z

#antigen theme agnoster/agnoster-zsh-theme agnoster.zsh-theme
#antigen theme prikhi/molokai-powerline-zsh molokai-powerline-zsh
antigen theme agnoster
#antigen bundle mafredri/zsh-async
#antigen bundle sindresorhus/pure

antigen apply



# (agnoster theme) To hide the mvalais@mba-mael, set DEFAULT_USER=mvalais
DEFAULT_USER=mvalais

#### Paths (from least important to most important) ####
#export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"
if [ -d '/Applications/Ipe.app' ]; then
      export PATH="$PATH:/Applications/Ipe.app/Contents/MacOS"
fi

if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH" # for 'stack'
fi
if [ -d "$HOME/bin" ]; then
  export PATH="$HOME/bin:$PATH"
fi

#export PATH=/Applications/MATLAB_R2016a.app/bin:$PATH
# An alias to matlab to be able to use it command-line
#alias matlab="matlab -nodisplay -nodesktop"

# Reminder for later: MANPATH should not be set manually as it
# will be deduced from the */bin directories in the PATH as well
# as the /etc/man.conf file.
# Warkaround: we first ask man to tell us the MANPATH when no
# MANPATH is set, and then (in the rest of this .zshrc) we can
# append others.
export MANPATH="$(man -w)"

# Coreutils 5.93 (2005) are COMPLETELY outdated as it was the last version that
# shipped without the GPL version (or such). So I had to install coreutils
# using brew.
if which /usr/local/opt/coreutils/libexec/gnubin/ls >/dev/null 2>&1; then
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
  #export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

# Gnu-sed (brew install gnu-sed)
if which /usr/local/opt/gnu-sed/libexec/gnubin/sed >/dev/null 2>&1; then
  export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
  #export MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"
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
alias polatouche="ssh -Y mvalais@polatouche.irit.fr"

alias plm="ssh -Y mvalais@ssh.math.cnrs.fr"

alias slurm-gui="ssh -Y mvalais@osirim-slurm.irit.fr sview"

alias kumo="ssh -Y mvalais@kumo.irit.fr"

if which hub >/dev/null 2>&1; then
  alias git=hub
fi

if which exa >/dev/null 2>&1; then
  alias ls="exa"
elif ls --version | grep coreutils >/dev/null 2>&1; then
  # If (GNU coreutils) ls is available
  alias ls='ls --color=auto'
elif ls -G >/dev/null 2>&1; then
  # If FreeBSD (=mac) ls is available
  alias ls="ls -G"
fi

alias tlmonfly="texliveonfly"

alias f=fzf
function lw() { exa -l $(which -a $1 | awk '/: (aliased to|shell built-in)/ {print > "/dev/stderr"; next} {print; next}') }

# Preferred editor for local and remote sessions
export GIT_EDITOR='vim' # by default
export HGEDITOR='vim'
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
elif which code >/dev/null 2>&1; then
  export EDITOR='code'
  # If we are inside vscode, git commit will open in vscode
  if [[ -n $VSCODE_PID ]]; then
    export GIT_EDITOR='code --wait'
    export HGEDITOR='code --wait'
  fi
else
  which mvim >/dev/null 2>&1 && export EDITOR='mvim'
fi

# OPAM initialization
if which opam >/dev/null 2>&1; then
  eval $(opam env)
fi

# Line added by iterm2 to enable the shell integration. But it messes with my
# oh_my_zsh theme (agnoster) so I had to disable it...
# The issue appears to be the prompt, showing a small ">" instead of " ~ "
# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


alias mlre="pbpaste | refmt --parse ml --print re --interface false | pbcopy"
alias reml="pbpaste | refmt --parse re --print ml --interface false | pbcopy"

export VAGRANT_HOME=/Volumes/Stockage/vagrant.d

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

# From 10.2, MANPATH should not be set; if it is, 'man' will skip
# a big part of the man search (example with man -d man).
# See http://hints.macworld.com/article.php?story=20031014053111192
unset MANPATH

alias hg=chg

# ZSH / BASH users
# Add this to your .env, .bashrc, .zshrc, or whatever file you're using for environment
# Note from Mael: this is exactly what
#    antigen bundle colored-man-pages
# does. But for some reason 'colored-man-pages' doesn't work on macos.
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
export PERL5LIB=$HOME/perl5/lib/perl5

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# From: https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236
# GIT heart FZF
# --------------

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --height 50% "$@" --border
}

alias gf && unalias gf || true
alias gb && unalias gb || true
alias gr && unalias gr || true
gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --color=always --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -'$LINES
}

gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --color=always --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}
join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-git-helper() {
  local char
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}
bind-git-helper f b t r h
unset -f bind-git-helper

# Fix tmux haing wrong grey
# https://unix.stackexchange.com/questions/139082/zsh-set-term-screen-256color-in-tmux-but-xterm-256color-without-tmux
[[ $TMUX != "" ]] && export TERM="screen-256color"
