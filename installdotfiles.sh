#! /bin/bash
#
# installdotfiles.sh
# Maël Valais
#
# This script creates symlinks to every .files in the current directory
# into the ~/ directory. Overwritten ~/.files will be stored into old_dotfiles/
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
#     find ~ -maxdepth 1 ! -type l ! -type d 
# lists every normal file (no directories, no symlinks)
while read dotfile;  do 
    dotfile=`basename "$dotfile"`
    if [ "$dotfile" != ".DS_Store" ]; then
        found=0
        while read dotfile_in_home; do
            dotfile_in_home=`basename "$dotfile_in_home"`
            if [ "$dotfile" == "$dotfile_in_home" ]; then
                echo "Moving $dotfile_in_home to old_dotfiles and symlinking instead with $dotfile"
                mv ~/$dotfile_in_home "old_dotfiles/"
                ln -s `pwd`/"$dotfile" ~/"$dotfile"
                found=1
            fi
        done <<< $(find ~ -maxdepth 1 ! -type l ! -type d -iname ".*")
        if [ $found -eq 0 ]; then
            # Check if this .file has already a symlink in ~
            if (find ~/$dotfile -maxdepth 1 -type l 2>/dev/null >/dev/null); then
                already=$dotfile $already
                echo "$dotfile" already has a symlink in home.
            else
                echo "No ~/$dotfile. Directly symlinking."
                ln -s `pwd`/"$dotfile" ~/"$dotfile"
            fi
             
        fi
    fi
done <<< $(find . -maxdepth 1 ! -type l ! -type d -iname ".*")

if [ "$already" -a "$1" == "-f" ]; then
    while read dotfile; do 
        rm ~/"$dotfile"
        ln -s `pwd`/"$dotfile" ~/"$dotfile"
        echo "Replaced ~/$dotfile symlink."
    done <<< $(echo "$already")
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
#     echo "Moving any existing dotfiles from ~ to $olddir"
#     mv ~/.$file ~/dotfiles_old/
#     echo "Creating symlink to $file in home directory."
#     ln -s $dir/$file ~/.$file
# done
