# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#---------------------Mina egna hittepå-grejer ---------------------

# Nicer ls: -f for file type indication (/ for dir, @ for link).
# -h for sizes in kB, MB etc instead of frickin bytes.
# -v for natural order (10 after 1).
# G for colours.
alias l='ls -FhvG'
alias la='l -A'

# Shorter source command
alias so='source'

# cs = cd + ls
function cs() { cd "$@" && l; }
# Because I keep typing the wrong command
alias cl='cs'

# hex x takes decimal x to its hexdecimal representation
function dec() { echo "$((0x$@))"; }
# dec x takes hexdecimal x to its decimal representation WIP
function hex() { echo "ibase=10;obase=16;$@" | bc; }

# alias for my config files git system. You don't want to pollute $HOME with git
# files, so we have a .dotfiles directory there, where git lives.  To call git
# in that directory but with $HOME as working tree, use the below alias instead
# of git.
alias dotfiles='git --git-dir ~/.dotfiles/.git --work-tree=$HOME'

