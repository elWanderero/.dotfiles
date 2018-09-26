# *.profile files are read by "login" shells, i.e. when logging in directly to a shell,
# such as when running Ubuntu on Windows, or when using SSH. .profile is the general
# file. .bash_profile (this file) is for Bash. If it exists Bash ignores .profile.
#     Bash is special in that if is accessed as a login shell, it ignores the .bashrc
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
