How to use this repository?
=======

You should clone this repository into you unik-like environment **HOME** directory. 

--------
### A), Use git to clone this repository into your home directory;
  1. git init
  2. git remote add origin PATH/TO/REPO
  3. git fetch -f 
  4. git checkout -t -f origin/main

###### Quick Command
    git init; git remote add -f -t main -m main origin https://gitee.com/wangyuhuai/dotFiles.git; git checkout -f main

-------- 
### B), Add the below scripts into your shell config file, Such as .bashrc;
    if [ -f "$HOME/.shell_settings" ]; then
        source "$HOME/.shell_settings"
    fi

-------- 
### C), Run the below shell command to apply the above changes;
    $ source <shell config file>

