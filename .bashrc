#  bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
	#  如果希望每次ssh连接时都进入不同的tmux环境，并且ssh断开连接时自动关闭则启动下面这行
	tmux new-session \; set-option destroy-unattached on
	#如果希望每次通过ssh连接进入同一个tmux环境（就如同ssh从来没断过一样）,启用下面这样
	#tmux has 2> /dev/null || tmux new-session -s ssh_tmux && tmux attach
fi

# User specific aliases and functions
alias cls='clear'
alias ll='ls -a'
alias l='ls'
alias vimrc='vim ${HOME}/.vim/vimrc'
alias tu='tmux -u'
PS1="\[\033[1;37;1m\]\[\033[0;32;1m\]\H : \[\033[1;33;1m\]\w\[\033[1;37;1m\]\[\033[1;37;1m\] > \[\033[1;37;1m\]"

# fzf
[ -f ~/.fzf.bash  ] && source ~/.fzf.bash

export FZF_COMPLETION_TRIGGER=''
alias fzf='fzf --preview "cat {}" '

fag(){
  local line
  line=`ag --nocolor "$1" | fzf` \
    && vim $(cut -d':' -f1 <<< "$line") +$(cut -d':' -f2 <<< "$line")
}
