
# enable color support of ls and also add handy aliases
if ${use_color} ; then

    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto -i'
    alias fgrep='fgrep --color=auto -i'
    alias egrep='egrep --color=auto -i'
    alias ls='ls -lv --group-directories-first --color=auto'
    alias ll='ls --group-directories-first -alF --color=auto'
    alias la='ls -AC --group-directories-first --color=auto'
    alias l='ls --group-directories-first -CF --color=auto'
    skinfile="modar"
    
    if [[ ${num_color} == 8 ]] ; then
        skinfile+="con16"
    else 
        skinfile+="in256"
    fi
    [[ ${EUID} == 0 ]] && skinfile+="root"
    skinfile+="-defbg"
    alias mc='mc -S $skinfile'
    
    if [ -x /usr/bin/dircolors ]; then
        #test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        # Enable colors for ls, etc.  Prefer users own ~/.dir_colors
            if [[ -f ~/.dir_colors ]] ; then
                #echo "  using users ls colors..."
                eval $(dircolors -b ~/.dir_colors)
            elif [[ -f /etc/DIR_COLORS ]] ; then
                eval $(dircolors -b /etc/DIR_COLORS)
            fi
    fi

else
    alias ls='ls -lv --group-directories-first'
    alias ll='ls --group-directories-first -alF'
    alias la='ls -AC --group-directories-first'
    alias l='ls --group-directories-first -CF'
    alias grep='grep -i'
    alias fgrep='fgrep -i'
    alias egrep='egrep -i'

fi



#update my ip on freedns.org
alias upeip='curl http://freedns.afraid.org/dynamic/update.php?dmhwT3pnS0FyclI3MkdSRjZvaGU6NjAzNDU='
alias danny='for i in {1..256};do tput setaf $i; echo -n "Danny and freya rule "  ; done '

alias ct='scp {\.bashrc,.bash_profile,.bash_aliases} daz@192.168.1.110:/home/daz' 
alias tsys='tail -n20 /var/log/syslog'
alias hg='history | grep'
alias p='ps ax | grep'
alias free='free -h'
alias df='df -h'

alias hfix='history -n && history | sort -k2 -k1nr | uniq -f1 | sort -n | cut -c8- > ~/.tmp$$ && history -c && history -r ~/.tmp$$ && history -w && rm ~/.tmp$$'
alias ltmux="if tmux has; then tmux attach; else tmux new; fi"

#gentoo 
alias emerge='emerge --ask -j9'
alias emergeup='emerge --update --deep --with-bdeps=y --newuse @world'
