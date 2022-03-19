# User dependent .bashrc file
if [ -f "$HOME/.bashrc" ] ; then
  source "$HOME/.bashrc"
fi

if [ -f "$HOME/.cargo/env" ] ; then
  source "$HOME/.cargo/env"
fi

