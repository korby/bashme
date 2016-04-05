#!/bin/bash
function inputrc {
  cat <<EOF > $HOME/.inputrc
"\e[A": history-search-backward
"\e[B": history-search-forward
"\e[C": forward-char
"\e[D": backward-char
EOF
}

function vimrc {
  cat <<EOF > $HOME/.vimrc
syntax on
EOF
}

function bashrc_c2is {
  cat <<EOF > $HOME/.bashrc_c2is
export HISTTIMEFORMAT="[%d/%m/%Y %T] "
export HISTSIZE="5000"
export HISTFILESIZE=""

export LS_OPTIONS='--color=auto'
eval "dircolors"
alias ls='ls \$LS_OPTIONS'
alias ll='ls \$LS_OPTIONS -l'
alias l='ls \$LS_OPTIONS -lA'
EOF
sed -i 's/dircolors/`dircolors/g' $HOME/.bashrc_c2is
sed -i 's/dircolors/dircolors`/g' $HOME/.bashrc_c2is
}

bashrc_c2is
source_it=". $HOME/.bashrc_c2is;"
if [ "$(grep "$source_it" $HOME/.bashrc)" == "" ]; then echo $source_it >> $HOME/.bashrc; fi;
. $HOME/.bashrc

if [ ! -f $HOME/.inputrc ];
then
    inputrc
    . $HOME/.inputrc
  else
    echo "$HOME/.inputrc already exists"
fi

if [ ! -f $HOME/.vimrc ];
then
    vimrc
  else
    echo "$HOME/.vimrc already exists"
fi

echo "You can change prompt pattern (PS1) and add additional information for all users by editing /etc/bash.bashrc"

# reload to take effect immediately
bash
