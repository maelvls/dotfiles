# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"
plugins=(wd)
#
# Infos irit:
# - www est dans /usr/local/WWW-personnel/mael.valais sur bali
# - sftp irit: ftpintra.irit.fr

#### My configuration ####
export PATH="$PATH:$HOME/bin"
export PATH="$HOME/.linuxbrew/bin:$PATH"
export PATH="$HOME/.linuxbrew/sbin:$PATH"

# An alias to matlab to be able to use it command-line
alias matlab="matlab -nodisplay -nodesktop"

alias aneto="ssh -Y mvalais@aneto.math.ups-tlse.fr"
alias imt=aneto
alias sasssh="ssh -Y vlm9212a@sasssh.univ-tlse3.fr" # -Y = fake X11 auth
alias ups=sasssh
alias sash="ssh -Y mvalais@sash.irit.fr"
alias irit=sash

alias bali="ssh -Y bali.irit.fr"
alias osirim="ssh -Y mvalais@osirim-slurm.irit.fr"
alias c7ni="ssh -Y c7ni.irit.fr"
alias polatouche="ssh polatouche.irit.fr"

alias tmux="tmux attach || tmux"

##########################

source $ZSH/oh-my-zsh.sh

source /home/mvalais/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/mvalais/.linuxbrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fpath=(/home/mvalais/.linuxbrew/share/zsh-completions $fpath)
# Line added by iterm2 to enable the shell integration. But it messes with my
# oh_my_zsh theme (agnoster) so I had to disable it...
# The issue appears to be the prompt, showing a small ">" instead of " ~ "
# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export JAVA_HOME=/usr/lib/jvm/java-openjdk/

PATH="/home/mvalais/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/mvalais/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/mvalais/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/mvalais/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/mvalais/perl5"; export PERL_MM_OPT;

# OPAM configuration
. /home/mvalais/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
