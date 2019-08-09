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

##########################################################
# alias
##########################################################

alias ll='ls -al'
alias l='ls'
alias vimrc='vim ${HOME}/.vim/vimrc'
alias bashrc='vim ${HOME}/.bashrc'
alias rel='source ${HOME}/.bashrc ${HOME}/.bash_profile'
alias tu='tmux -u'

alias grep="grep --color=auto"
alias mv="mv -b --backup=numbered"
alias cp="cp -i"
alias rm="rm2bin"

function rm2bin {
	for i in "$@"; do
		stat $i > /dev/null
		[[ $? -eq 0 ]] || return
		size=`ls -alh $i | awk '{print $5}' | grep 'G'`
		if [[ ! -z $size ]]; then
			del=""
			while true; do
				read -p "file $i is $size, do you want to delete it forever ?(yes/no)" del
				case $del in
					Y | y)
					rm -rf $i
					break;;
					N | n)
					break;;
					*)
					continue;;
				esac
			done
		fi
	done
	ls $@ | awk 'NR != 1 {if($5!~/**G/) print $NF}' | grep -v '^\.$\|^\.\.$' | xargs -n 10 -i mv -b --backup=numbered {} /tmp/
}

###########################################################
# environment
###########################################################

PS1="\[\033[1;37;1m\]\[\033[0;32;1m\]\H : \[\033[1;33;1m\]\w\[\033[1;37;1m\]\[\033[1;37;1m\] > \[\033[1;37;1m\]"
export TERM=xterm-256color

###########################################################
# work/business
###########################################################

## ->truncate<- ##
