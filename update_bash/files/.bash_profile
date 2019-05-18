# .bash_profile distributed from Foreman

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

PATH=$PATH:$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:$HOME/opt/texlive/2018/bin/x86_64-linux
export PATH
export PERL5LIB=$HOME/share/perl5:$HOME/lib64/perl5/vendor_perl

# make sure ssh-agent is running
# (Gnome keyring does not support recent crypt keys)
#if [ ! -S ~/.ssh/ssh_auth_sock ]; then
#        eval `ssh-agent`
#        ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
#fi
#export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
#ssh-add -l > /dev/null || ssh-add

