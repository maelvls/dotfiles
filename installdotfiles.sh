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

if [ ! -d "old_dotfiles" ]; 
    then mkdir old_dotfiles; 
fi
already=""
# The command 
#     find $HOME -maxdepth 1 ! -type l ! -type d 
# lists every normal file (no directories, no symlinks)
while read dotfile;  do 
    found=0
    while read dotfile_in_home; do
        if [ "$dotfile" == "$dotfile_in_home" ]; then
            echo "Moving $dotfile_in_home to old_dotfiles and symlinking instead with $dotfile"
            echo mv $HOME/$dotfile_in_home "old_dotfiles/"
	    mv $HOME/$dotfile_in_home "old_dotfiles/"
	    echo ln -s `pwd`/"$dotfile" $HOME/"$dotfile"
            ln -s `pwd`/"$dotfile" $HOME/"$dotfile"
            found=1
        fi
done < <(find $HOME -maxdepth 1 ! -type l ! -type d \
	\( -name ".*" -a ! -name ".DS_Store" \) -exec basename {} \;)
    if [ $found -eq 0 ]; then
        # Check if this .file has already a symlink in $HOME
        if (find "$HOME/$dotfile" -maxdepth 1 -type l 2>/dev/null >/dev/null); then
            already="${dotfile} ${already}"
            echo "$dotfile" already has a symlink in home.
        else
            echo "No $HOME/$dotfile. Directly symlinking."
            echo ln -s "$PWD/$dotfile" "$HOME/$dotfile"
	    ln -s "$PWD/$dotfile" "$HOME/$dotfile"
        fi
         
    fi
done < <(find . -maxdepth 1 ! -type l ! -type d \
	   \( -name ".*" -a ! -name ".DS_Store" \) -exec basename {} \;)

if [ "$already" -a "$1" == "-f" ]; then
    for dotfile in `echo $already`; do 
        rm "$HOME/$dotfile"
        ln -s "$PWD/$dotfile" "$HOME/$dotfile"
        echo "Replaced $HOME/$dotfile symlink."
    done
else 
    echo "The following files already exist in home:"
    echo $already
    echo $0 -f to force symlink
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

if which brew >/dev/null 2>&1; then
    brew bundle --global
fi


# Install Vundle for Vim
[ -d "$HOME/.vim/bundle/Vundle.vim" ] || git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
