DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [[ ! -d "$HOME/.vim" ]]; then
    ln -s $DIR ~/.vim
    ln -s $DIR/vimrc.vim ~/.vimrc
    mkdir $DIR/undodir
    # For IntelliJ vim-mode
    # ln -s $DIR/vimrc.vim ~/.ideavimrc
    echo "Symlinked vim configuration"
else
    echo "Vim configuration already exists"
fi
