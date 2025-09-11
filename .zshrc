# User dependent .shell_settings file
if [ -f "$HOME/.shell_settings" ]; then
    source "$HOME/.shell_settings"
fi

#Reset Prompt
export PROMPT='[[%F{magenta}0%f]] %F{cyan}%m%f %F{blue}{%f %F{red}%1~%f %F{blue}}%f %F{yellow}%#%f '

