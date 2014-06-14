
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize
shopt -s -o noclobber
shopt -s histappend
shopt -s -o ignoreeof
shopt -u sourcepath

HISTSIZE=1000
HISTFILESIZE=4000
# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
#export HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}erasedups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignorespace:erasedups
# alias hfix='history -n && history | sort -k2 -k1nr | uniq -f1 | sort -n | cut -c8- > ~/.tmp$$ && history -c && history -r ~/.tmp$$ && history -w && rm ~/.tmp$$'  
#shopt -s extglob  
#export HISTIGNORE="!(+(*\ *))"  
#DPROMPT_COMMAND="hfix; $PROMPT_COMMAND" 

#bind set history-preserve-point on

#export EDITOR=/usr/bin/joe
# [ -x /usr/bin/vim ]
VIMRUNTIME=/usr/share/vim

LESS='-R -M --shift 5'
LESSOPEN='|lesspipe %s'

#if we run under X get some stuff in
[ -x /usr/bin/xrdb ] && /usr/bin/xrdb -load .Xdefaults

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

if [ -f ~/.bashrc ] ; then
    . ~/.bashrc
fi
