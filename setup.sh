SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )
ln -s $SCRIPTPATH ~/.vim
ln -s $SCRIPTPATH/vimrc.vim ~/.vimrc

ln -s $SCRIPTPATH/vimrc.vim ~/.ideavimrc
