How to use this repository?
=======

You should clone this repository into you unik-like environment **HOME** directory. 

--------
### A), Use git to clone this repository into your home directory;
  1. git init
  2. git remote add origin PATH/TO/REPO
  3. git fetch -f 
  4. git checkout -t -f origin/master
  5. git submodule update --init --recursive

###### Quick Command
    git init && git remote add origin https://github.com/Ywang153/dotFiles.git && git fetch -f && git checkout -t -f origin/master

-------- 
### B), Add the below scripts into your shell config file, Such as .bashrc;
    if [ -f "$HOME/.shell_settings" ]; then
        source "$HOME/.shell_settings"
    fi

-------- 
### C), Run the below shell command to apply the above changes;
    $ source <shell config file>

