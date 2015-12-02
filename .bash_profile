# $Revision$
SCRSHELL=$SHELL
[ -f ~/.bashrc ] && . ~/.bashrc
[ -f ~/.bash_profile-local ] && . ~/.bash_profile-local
#[ -d ~/opt ] && PATH="~/opt/bin:${PATH}"
[ -d ~/bin ] && PATH=~/bin:"${PATH}"

