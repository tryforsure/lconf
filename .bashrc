# ~/.bashrc
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#if [[ $- != *i* ]] ; then  #	# Shell is non-interactive.  Be done now! #	return   #fi

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Change the window title of X terminals to user@host:dir
case ${TERM} in
    xterm*|rxvt*|Eterm|aterm|kterm|gnome*|interix*)
            PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
    ;;
    screen)
            PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\033\\"'
    ;;
esac


#we want color, we want color, we want color
if [ -x /usr/bin/tput ] && tput setaf 2 >&/dev/null; then
    num_color=$(tput colors)
    use_color=true
else
    use_color=
fi



#TTYNAME=`tty|cut -b 6-`

# match_lhs=""
# [[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
# [[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
# [[ -z ${match_lhs}    ]] && type -P dircolors >/dev/null && match_lhs=$(dircolors --print-database)
# [[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

#Promt command to remeber history from multple sessions
PROMPT_COMMAND='history -n; history -w; history -c; history -r;$PROMT_COMMAND'

red_esc='\[\033[00;31m\]'
cyan_bold='\[\033[01;36m\]'
default='\[\033[00m\]'

restore='tput sgr0' # with tput

if ${use_color} ; then
        set colored-stats on
        if [[ ${EUID} == 0 ]] ; then
            # set for root
            PS1='\[\033[00;31m\]\h\[\033[01;36m\] \w\[\033[00;31m\]\$\[\033[00m\]'
        else
            #else for user
            PS1='\[\033[00;34m\]\u@\[\033[01;32m\]\h\[\033[01;36m\] \w\[\033[00;34m\]\$\[\033[00m\]'
        fi
else
        if [[ ${EUID} == 0 ]] ; then
            # show root@ when we don't have color
            PS1='\u@\h \w \$'
        else
            PS1='\u@\h \w \$'
        fi
fi

# Enable programmable completion features and Alias definitions.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
   . /etc/bash_completion
fi

unset safe_term match_lhs force_color_prompt use_color


#if ping -c archlinux.org > /dev/null; then 
#fi

#[ ! "grep $USER /etc/passwd >/dev/null" ] && echo "your user account is not managed locally"; 

#export PS1='\[33[01;34m\][\w]\n\[33[01;31m\]\u@\h\[33[01;34m\]($TTYNAME)$ \[33[00m\]'


#below are fun functions for me to play with
#myc is a function
myc ()
{
    local x;
    if [ $# -lt 1 ]; then
        echo "This function evaluates arithmetic for you if you give it some";
    else
        if (( $* )); then
            let x="$*";
            echo "$* = $x";
        else
    echo "$* = 0 or is not an arithmetic expression";
        fi;
    fi
}

# save, clear screen
#tput smcup
#clear
# example "application" follows...
#read -n1 -p "Press any key to continue..."
# example "application" ends here
# restore
#tput rmcup

# net rpc -S <ip address> -U <username>%<password> shutdown -t 1 -f
status() {
      { echo -e "\nuptime:"
        uptime
        echo -e "\ndisk space:"
        df -h 2> /dev/null
        echo -e "\ninodes:"
        df -i 2> /dev/null
        echo -e "\nblock devices:"
        blkid
        echo -e "\nmemory:"
        free -h -m
        if [[ -r /var/log/syslog ]]; then
          echo -e "\nsyslog:"
          tail /var/log/syslog
        fi
        if [[ -r /var/log/messages ]]; then
          echo -e "\nmessages:"
          tail /var/log/messages
        fi
      }
less
}

# Securely destroy data on given device hugely faster than /dev/urandom
# This command generates a pseudo-random data stream using 
#aes-256-ctr with a seed set by /dev/urandom. Redirect to a block device for secure data scrambling.
# openssl enc -aes-256-ctr -pass pass:"$(dd if=/dev/urandom bs=128 count=1 2>/dev/null | base64)" -nosalt < /dev/zero > randomfile.binopenssl enc -aes-256-ctr -pass pass:"$(dd if=/dev/urandom bs=128 count=1 2>/dev/null | base64)" -nosalt < /dev/zero > randomfile.bin


function hg () { history | grep $* ; } # define a function combining history and grep to save typing :-)

printascii() {
for i in {1..256};do p=" $i";echo -e "${p: -3} \\0$(($i/64*100+$i%64/8*10+$i%8))";done|cat -t|column -c120
}

google() { 
  Q="$@"; 
  GOOG_URL='https://www.google.co.uk/search?q='; 
  AGENT="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.152 Safari/537.36" 
  links -dump "${GOOG_URL}${Q//\ /+}" | grep "\*" | head -1 
  }

# Apply, in parallel, a bc expression to CSVApply, in parallel, a bc expression to CSV
pbc() { 
echo "get paralle;";
exit 0;
parallel -C, -k -j100% "echo '$@' | bc -l"; 
}
