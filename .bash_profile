#!/bin/bash
# *.profile files are read by "login" shells, i.e. when logging in directly to a shell,
# such as when running Ubuntu on Windows, or when using SSH. .profile is the general
# file. .bash_profile (this file) is for Bash. If it exists Bash ignores .profile.
#     Bash is special in that if it is accessed as a login shell, it ignores the .bashrc
# and reads only the profile. Thus it needs to be included here.

# We do everything in our power to kill every fucking beep and blink in the entire system.
if [[ "$TERM" != "xterm-256color" && "$TERM" != "putty-256color" ]]; then
    setterm -blength 0
fi

# Without this .bashrc is not sourced when logging directly into a terminal, such as when
# SSH-ing in. The '.' is because the file is "sourced," not "loaded." Whatever that means.
# Note the conditional: Only include .bashrc if it exists.
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

# I think this was added automatically by iterm on mac, to enable their nifty shell integration.
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

