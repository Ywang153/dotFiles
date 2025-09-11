# User dependent .shell_settings file
if [ -f "$HOME/.shell_settings" ]; then
    source "$HOME/.shell_settings"
fi

# Set bash prompt
if [[ ${TERM} != 'fbterm' ]]; then
    export PS1="\[\e]0;\a\]\n\[\033[37m\][[\[\033[35m\]\j\[\033[37m\]]] \[\033[36m\]\h \[\033[34m\]{ \[\033[31m\]\W \[\033[34m\]} \[\033[33m\]\$ \[\033[0m\]"
fi

# Auto complete insensitive
shopt -s nocaseglob
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob 
shopt -s dotglob 

