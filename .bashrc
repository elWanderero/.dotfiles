#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells. For most other stuff,
# by interactive shells, which may be log-in or not.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# I'm using distinct colors for the prompt. Makes it easier to see where things start and end.
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f "/etc/bash_completion" ] && ! shopt -oq posix; then
    # shellcheck source=/dev/null
    . /etc/bash_completion
fi

# If this path exists, then postgres is probably installed, and  that
# is probably its desired data area. We set the environemt variable
# for it here so that pg_ctl does not have to be called with a path.
if [ -d '/usr/local/var/postgres' ]; then
    export PGDATA=/usr/local/var/postgres
fi

# NVM installations location
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    # For nvm installed regularly, with curl and a shell script:
    # [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    # [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi
# For NVM installed with brew
if brew_nvm_dir=$(brew --prefix "nvm"); then
    # shellcheck source=/usr/local/opt/nvm/nvm.sh
    [ -s "$brew_nvm_dir/nvm.sh" ] && \. "$brew_nvm_dir/nvm.sh"  # This loads nvm
fi

# For Android Studio. Path exists if JDK exists on mac, I think.
if [ -d /usr/libexec/java_home ]; then
    JAVA_HOME=$(/usr/libexec/java_home)
    export JAVA_HOME
fi

# init of thefuck tool.
eval "$(thefuck --alias)"

# Always compile rust targetting the local CPU. Allows for most aggressive optimisations.
export RUSTFLAGS='-Ctarget-cpu=native'

# pyenv, if pyenv has not been initiated from .bash_profile
# if command -v pyenv >/dev/null; then eval "$(pyenv init -)"; fi

# eval "$(pyenv virtualenv-init -)"

###########################
#       AUTOCOMPLETE      #
###########################

# Brew bash autocompletions
if type brew &>/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    # shellcheck source=/usr/local/etc/profile.d/bash_completion.sh
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      # shellcheck disable=1090
      [[ -r "$COMPLETION" ]] && source "$COMPLETION"
    done
  fi
fi

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 2>/dev/null ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end

###########################
#          PATHS          #
###########################

# set PATH so it includes user's private /bin if it exists. Stuff like this should be
# done here and not in .bash_profile, because we want environment variables to be
# usable in interactive shells.
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Also include my private /scripts in PATH, where .sh scripts may be kept. See the
# comment above the bin-include for why we put this here and not in .bash_profile.
if [ -d "$HOME/scripts" ] ; then
    PATH="$HOME/scripts:$PATH"
fi

# Add . to PATH so we can run scripts in . without the ./ prefix
# Add it last to give it lowest priority to avoid problems
PATH=$PATH:.


###########################
#         IMPORTS         #
###########################

# Alias definitions in separate file. Also functions go in there.
if [ -f "$HOME/.bash_aliases" ]; then
    # shellcheck source=/Users/danielzs/.bash_aliases
    . "$HOME/.bash_aliases"
fi

# git autocomplete, including branches
if [ -f "$HOME/scripts/.git-completion.bash" ]; then
  # shellcheck source=/Users/danielzs/scripts/.git-completion.bash
  . "$HOME/scripts/.git-completion.bash"
fi

# Work stuff
if [ -f "$HOME/.bash_purspot" ]; then
    # shellcheck source=/Users/danielzs/.bash_purspot
    . "$HOME/.bash_purspot"
fi
if [ -f "$HOME/.bash_consid" ]; then
    # shellcheck source=/Users/danielzs/.bash_consid
    . "$HOME/.bash_consid"
fi

# shellcheck source=/Users/danielzs/.cargo/env
source "$HOME/.cargo/env"
