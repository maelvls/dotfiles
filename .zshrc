#! /usr/bin/env sh
#
# My zsh config for non-interactive shells Maël Valais
# <mael.valais@gmail.com> 2016
#
# Shortcuts: ctrl+G for 'z-jump' + fzf ctrl+R for reverse-i-search history
#   (fzf) ctrl+T for fuzzy finder (fzf) ctrl-X then ctrl-E for editing
#   current command
#
# Features I love most about a shell
#  - up arrow should show me the history that begins with what I already
#    typed.
#  - a failed command should still be recorded in my history.
#  - ctrl-r should be extremely easy and performant
#  - z is awesome (although it's not specific to a shell)
#  - ctrl-x ctrl-e is awesome to edit multiline heredocs strings
#  - the prompt should show
#    1. git branch obviously, and any currently git operation (rebase...)
#    2. kubernetes cluster, context and namespace
#    3. the exit code if it's != 0
#    4. duration of the last command if it lasted more than 5 seconds

UPDATE_ZSH_DAYS=13
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
ZSH_HIGHLIGHT_MAXLENGTH=300

# Disable auto-cd when typing a command not found that has the same name as
# a directory. Very annoying with Go as the binary has the same name as the
# directory its main.go is in...
unsetopt AUTO_CD

# On linux, add brew to path
[ ! -d "$HOME/.linuxbrew" ] || export PATH="$HOME/.linuxbrew/bin:$PATH"
[ ! -d "/home/linuxbrew/.linuxbrew" ] || export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

alias urldecode='python -c "import urllib.parse; print(urllib.parse.unquote_plus(open(0).read()))"'

alias urlencode='python -c "import urllib.parse; print(urllib.parse.quote_plus(open(0).read()))"'

# I use direnv for loading .envrc when entering a folder
# brew install direnv / apt install direnv
eval "$(direnv hook zsh)"

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

# With oh-my-zsh, when I type something and then press the up arrow, I can
# browse the history of all commands that had this prefix. It's one of the
# killer features of OMZ in my opinion. And since I decided to drop OMZ
# entierly (just too slow), I want to have this feature. See:
# https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys
#autoload -U up-line-or-beginning-search
#autoload -U down-line-or-beginning-search
#zle -N up-line-or-beginning-search
#zle -N down-line-or-beginning-search
#bindkey "^[[A" up-line-or-beginning-search # Up
#bindkey "^[[B" down-line-or-beginning-search # Down

# In don't want to rely on OMZ anymore. But I love this word-to-word jump on
# ctrl-left-arrow and ctrl-right-arrow (instead of jumping to the next space,
# it jumps to the next word).
# https://coderwall.com/p/a8uxma/zsh-iterm2-osx-shortcuts
#
# DOES NOT WORK AS INTENDED :(
#bindkey "^[b" backward-word
#bindkey "^[f" forward-word
bindkey "\e\e[D" backward-word
bindkey "\e\e[C" forward-word

# Search antigen
if [ -f /usr/share/zsh/share/antigen/antigen.zsh ]; then
  source /usr/share/zsh/share/antigen/antigen.zsh
elif [ -f $HOME/.antigen.zsh ]; then
  # Warning: apt install zsh-antigen seems way too old.
  # Prefer installing it with: curl -L git.io/antigen > ~/.antigen.zsh
  source $HOME/.antigen.zsh
else
  echo -e "\033[93mantigen:\033[0m antigen.zsh not installed?"
fi

export ZSH_AUTOSUGGEST_USE_ASYNC=1

# When I developon my own forl of omz, remember to use
#    antigen update maelvls/oh-my-zsh
#    antigen cache-gen
#export ANTIGEN_OMZ_REPO_URL=https://github.com/maelvls/oh-my-zsh.git

# Must-haves
antigen use oh-my-zsh
antigen bundle rupa/z
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions

# Not really must-haves
antigen bundle andrewferrier/fzf-z
antigen bundle psprint/zsh-navigation-tools
antigen bundle lukechilds/zsh-nvm
antigen bundle gitfast
#antigen bundle fzf
antigen bundle docker docker-compose
#antigen bundle git
#antigen bundle jsontools
#antigen bundle zsh-users/zsh-history-substring-search

#antigen theme agnoster/agnoster-zsh-theme agnoster.zsh-theme
#antigen theme prikhi/molokai-powerline-zsh molokai-powerline-zsh
#antigen theme agnoster
#antigen theme borekb/agkozak-zsh-theme@prompt-customization
#antigen theme borekb/agkozak-zsh-theme
#antigen bundle mafredri/zsh-async
#antigen bundle sindresorhus/pure
antigen bundle agkozak/agkozak-zsh-prompt

#antigen theme "$HOME/code/agkozak-zsh-prompt"
AGKOZAK_CUSTOM_SYMBOLS=('⇣⇡' '⇣' '⇡' '+' 'x' '!' '>' '?')
AGKOZAK_LEFT_PROMPT_ONLY=1
AGKOZAK_USER_HOST_DISPLAY=0

antigen apply

# (agnoster theme) To hide the mvalais@mba-mael, set DEFAULT_USER=mvalais
DEFAULT_USER=mvalais

#eval "$(starship init zsh)"

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

export PATH="$PATH:/usr/local/sbin"

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

# I want to be sure python2 won't be used in my workflows
if which /usr/local/opt/python/libexec/bin/python >/dev/null 2>&1; then
  export PATH="/usr/local/opt/python/libexec/bin:$PATH"
fi

# Gnu-sed (brew install gnu-sed)
if which /usr/local/opt/gnu-sed/libexec/gnubin/sed >/dev/null 2>&1; then
  export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
  #export MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"
fi

if [ -d "$HOME/go" ]; then
  export GOPATH="$HOME/go"
  export PATH="$GOPATH/bin:$PATH"
  export GO111MODULE=auto
fi

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

alias l="exa -l"
alias ll="exa -la"
alias f=fzf
alias vim=nvim

whichl() { which -a "$1" | awk '/(aliased to|shell built-in|not found)/ {print > "/dev/stderr"; next} {print; next}'; }
lwl() { whichl "$1" | xargs readlink -f | xargs exa -l; }
lw() { whichl "$1" | xargs readlink -f; }

# Preferred editor for local and remote sessions
export GIT_EDITOR='nvim' # by default
export FCEDIT='vim'      # for 'fc' (fix command)
export HGEDITOR='vim'
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
elif which code >/dev/null 2>&1; then
  #export EDITOR='code --wait'
  export EDITOR='nvim'
  # If we are inside vscode, git commit will open in vscode
  if [[ -n $VSCODE_PID ]]; then
    export GIT_EDITOR='code --wait'
    export HGEDITOR='code --wait'
  fi
else
  which mvim >/dev/null 2>&1 && export EDITOR='mvim'
fi

# OPAM initialization
#if which opam >/dev/null 2>&1; then
#  eval $(opam env)
#fi

# Line added by iterm2 to enable the shell integration. But it messes with my
# oh_my_zsh theme (agnoster) so I had to disable it...
# The issue appears to be the prompt, showing a small ">" instead of " ~ "
# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

alias mlre="pbpaste | refmt --parse ml --print re --interface false | pbcopy"
alias reml="pbpaste | refmt --parse re --print ml --interface false | pbcopy"

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
uri() {
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

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# From: https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236
# GIT heart FZF
# --------------
# <DELETED>

# Fix tmux haing wrong grey
# https://unix.stackexchange.com/questions/139082/zsh-set-term-screen-256color-in-tmux-but-xterm-256color-without-tmux
[[ $TMUX != "" ]] && export TERM="screen-256color"

# added by travis gem
[ -f /Users/mvalais/.travis/travis.sh ] && source /Users/mvalais/.travis/travis.sh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/mvalais/.sdkman"
[[ -s "/Users/mvalais/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/mvalais/.sdkman/bin/sdkman-init.sh"

export HOMEBREW_AUTO_UPDATE_SECS=3600

[ -s "/Users/mvalais/.jabba/jabba.sh" ] && source "/Users/mvalais/.jabba/jabba.sh"

# Kubectl is soooo long to type
alias k=kubectl

export ERL_AFLAGS="-kernel shell_history enabled"

# When I used to use Python for an interview test
#export PATH="/Users/mvalais/.pyenv/bin:$PATH"
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"

# gnupg2 says 'error: gpg failed to sign the data fatal: failed to write commit object'
# https://stackoverflow.com/questions/39494631/gpg-failed-to-sign-the-data-fatal-failed-to-write-commit-object-git-2-10-0
export GPG_TTY=$(tty)

export GOORI=$GOPATH/src/github.com/ori-edge

# So much guilt when developping :)
alias guilt=git
alias strace=dtruss
alias os=openstack

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault

# brew cask info google-cloud-sdk
#source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
#source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

# kubectl krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# wireshark
export PATH="$PATH":/Applications/Wireshark.app/Contents/MacOS/

# Ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/lib/ruby/gems/2.6.0/bin:$PATH"

export LPASS_AGENT_TIMEOUT=0

complete -o nospace -C /Users/mvalais/go/bin/mc mc

alias kk="cd ~/code/kubernetes"

# Remeber that oh-my-zsh is also setting HISTSIZE. So I have
# to keep these at the end of zshrc to avoid being overwritten.
# I had to set another HISTFILE due to the fact that (somehow) the
# ~/.zsh_history would get emptied for no reason, probably due to $HOME not
# being set? It seems to always happen after a Time Machine backup?
# See: https://unix.stackexchange.com/questions/568907/why-do-i-lose-my-zsh-history
HISTFILE=~/.zsh_hist
HISTSIZE=500000
SAVEHIST=500000
setopt EXTENDED_HISTORY

alias rgv="rg -g'!vendor'"
alias fdv="fd -E'vendor'"
alias t=terraform

alias kall="kubectl api-resources --verbs=list --namespaced -o name | grep ori.co | xargs -P16 -n1 kubectl get --show-kind -A 2>/dev/null"

# MacOS trick: change the screenshot generated name.
# Source: https://apple.stackexchange.com/questions/251385
#
# ⚠️  You can't change the name of generated screenshots!
#
# defaults write com.apple.screencapture "include-date" 0
# defaults write com.apple.screencapture name screenshot-"$(date +%Y-%m-%d)-$(date +%H%M)"

alias m=make
if [ -e /Users/mvalais/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/mvalais/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

digc() {
  dig $* | awk '
    !/^;/           { print $0 }
    /^;[^;]/        { print "\033[1;35m"$0"\033[0m" }
    /^;;/           { print "\033[1;30m"$0"\033[0m" }
  ' | sed 's|\(IN\)|\\033[1;33m\1\\033[0m|' | xargs -0 printf
}

export WASMTIME_HOME="$HOME/.wasmtime"

export PATH="$WASMTIME_HOME/bin:$PATH"

alias cat=bat
alias b=bazel
export PATH="/usr/local/opt/gcore/bin:$PATH"

setopt share_history

export PATH="$(gem env gemdir)/bin:$PATH"
