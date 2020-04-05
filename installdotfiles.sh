#! /bin/bash
#
# installdotfiles.sh
# Maël Valais
#
# This script creates symlinks to every .files in the current directory
# into the $HOME/ directory. Overwritten $HOME/.files will be stored into old_dotfiles/
#
# Note: Remember to run "chmod +x installdotfile.sh" if any issues occur
#
# vim:set et sts=0 sw=4 ts=4:
#

gray='\033[90m'
red='\033[91m'
green='\033[92m'
yel='\033[93m'
# blu='\033[94m'
end='\033[0m'
function trace() {
    echo -ne "$1 ${gray}"
    LANG=C perl -e 'print join (" ", map { $_ =~ / / ? "\"".$_."\"" : $_} @ARGV)' -- "${@:2}"
    echo -e "${end}"
    command "$@"
}

HOME_DOTFILES=$(find "$HOME" -maxdepth 1 ! -type l ! -type d \( -name ".*" -a ! -name ".DS_Store" \) -exec basename {} \;)
PWD_DOTFILES=$(find . -maxdepth 1 ! -type l ! -type d \( -name ".*" -a ! -name ".DS_Store" \) -exec basename {} \;)

# Install Vim-plug for Vim 8
[ -f ~/.vim/autoload/plug.vim ] || curl -sfLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install gpakosz-tmux: https://github.com/gpakosz/.tmux.git
# My personal conf is in .tmux.conf.local
git submodule update
PWD_DOTFILES+=$'\n'gpakosz-tmux/.tmux.conf

FORCE=no
BREW=no
while [ $# -gt 0 ]; do
    case "$1" in
    --force | -f) FORCE=yes ;;
    --brew) BREW=yes ;;
    *) ;;
    esac
    shift
done

if [ ! -d "old_dotfiles" ]; then
    mkdir old_dotfiles
fi

ALREADY=""
# The command
#     find $HOME -maxdepth 1 ! -type l ! -type d
# lists every normal file (no directories, no symlinks)
for dotfile in $PWD_DOTFILES; do
    SOURCE="$PWD/$dotfile"
    TARGET="$HOME/$(basename "$dotfile")"
    found=0
    for dotfile_in_home in $HOME_DOTFILES; do
        if [ "$TARGET" == "$dotfile_in_home" ]; then
            echo "Moving ${yel}$dotfile_in_home${end} to ${yel}./old_dotfiles${end} and symlinking instead with ${yel}$dotfile${end}"
            trace mv "$HOME/$dotfile_in_home" "old_dotfiles/"
            trace ln -s "$SOURCE" "$TARGET" # source is in PWD, target is in HOME
            found=1
        fi
    done < <(echo "$HOME_DOTFILES")
    if [ $found -eq 0 ]; then
        # Check if this .file has already a symlink in $HOME
        if (find "$TARGET" -maxdepth 1 -type l 2>/dev/null >/dev/null); then
            if [ "$FORCE" = "no" ]; then
                echo -e "${yel}$dotfile${end} already has a symlink in home. To force resymlink, use ${red}--force${end}"
                ALREADY+="\n$dotfile"
            else
                echo -e "(${red}--force${end} mode) ${yel}$dotfile${end} already exists, resymlinking."
                trace ln -sf "$SOURCE" "$TARGET"
            fi
        else
            echo -e "No ${yel}$HOME/$dotfile${end}. Directly symlinking."
            trace ln -s "$SOURCE" "$TARGET"
        fi

    fi
done

if [ -n "$ALREADY" ] && [ "$1" == "-f" ]; then
    for dotfile in $ALREADY; do
        rm "$HOME/$dotfile"
        ln -s "$PWD/$dotfile" "$HOME/$dotfile"
        echo "Replaced $HOME/$dotfile symlink."
    done
elif [ -n "$ALREADY" ]; then
    echo -e "${red}The following files already exist in home:${end}"
    echo -e "${green}$ALREADY${end}"
    echo -e "\nYou can use '${green}$0 --force${end}' to force symlink"
fi
# find . -type t
# b       block special
# c       character special
# d       directory
# f       regular file
# l       symbolic link
# p       FIFO
# s       socket

# for file in $files; do
#     echo "Moving any existing dotfiles from $HOME to $olddir"
#     mv $HOME/.$file $HOME/dotfiles_old/
#     echo "Creating symlink to $file in home directory."
#     ln -s $dir/$file $HOME/.$file
# done

# Install tpm, the tmux package manager
[ -d "$HOME/.tmux" ] || mkdir "$HOME/.tmux"
[ -d "$HOME/.tmux/plugins/tpm" ] || git clone -q https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
[ -d "$HOME/.tmux/plugins/gpakosz-tmux-conf" ] || (git clone -q https://github.com/gpakosz/.tmux.git ~/.tmux/plugins/gpakosz-tmux-conf && ln -s -f ~/.tmux.conf ~/.tmux/plugins/gpakosz-tmux-conf/.tmux.conf)

# Install brew if not installed
if [ "$BREW" != yes ]; then
    exit 0
fi

if ! [ -d /usr/local/Cellar -o -d "$HOME/.linuxbrew" ] || [ -d "/home/linuxbrew/.linuxbrew" ]; then
    if [ "$(uname -s)" = Darwin ]; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
    fi
fi

BREWS=/tmp/brews
cat >$BREWS <<EOF
    coreutils
    curl
    diff-so-fancy
    git
    htop
    hub
    rlwrap
    tmux
    zsh
    antigen
    exa
    ripgrep
    fzf
    fd
EOF
# mac-only packages
if [ "$(uname -s)" = Darwin ]; then
    cat >>$BREWS <<EOF
    reattach-to-user-namespace
    pinentry-mac
EOF
fi

# Install the brew packages
if command -v brew >/dev/null 2>&1; then
    brew install $BREWS
fi
rm -f $BREWS
