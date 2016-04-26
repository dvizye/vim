DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [[ ! -d "$HOME/.vim" ]]; then
    ln -s $DIR ~/.vim
    ln -s $DIR/vimrc.vim ~/.vimrc
    # For IntelliJ vim-mode
    # ln -s $DIR/vimrc.vim ~/.ideavimrc
    "Symlinked vim configuration"
else
    echo "Vim configuration already exists"
fi
