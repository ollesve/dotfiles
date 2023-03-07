source ~/.profile

export NVM_DIR="$HOME/.nvm"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOROOT/bin"

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source /Users/ollesvensson/.docker/init-zsh.sh || true # Added by Docker Desktop
