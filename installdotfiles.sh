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

ls -p -a | grep -v / | grep '^\.' | while read dotfile;  do 
    if [ "$dotfile" != ".DS_Store" ]; then
        found=0
        ls -p -a ~ | grep -v / | grep '^\.' | while read dotfile_in_home; do
            if [ "$dotfile" == "$dotfile_in_home" ]; then
                echo "Moving \~/$dotfile to old_dotfiles and symlinking instead with $dotfile"
                mv ~/$dotfile_in_home "./old_dotfiles/"
                ln -s "$dotfile" "~/$dotfile"
                found=1
            fi
        done
        if [ $found -eq 1 ]; then
            echo "No \~/$dotfile. Directly symlinking."            
            ln -s "$dotfile" "~/$dotfile"            
        fi
    fi
done

# for file in $files; do
#     echo "Moving any existing dotfiles from ~ to $olddir"
#     mv ~/.$file ~/dotfiles_old/
#     echo "Creating symlink to $file in home directory."
#     ln -s $dir/$file ~/.$file
# done
