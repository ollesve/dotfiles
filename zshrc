source ~/.profile

# Git worktree helpers: wt, wt-done, wt-list, wt-cd
source "$HOME/Documents/code/dotfiles/worktree.zsh"

export NVM_DIR="$HOME/.nvm"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOROOT/bin"


# start ssh-agent
eval "$(ssh-agent -s)"

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ollesvensson/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ollesvensson/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ollesvensson/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ollesvensson/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# For JDK
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# For xcode env
export NODE_BINARY="$NVM_DIR/versions/node/v20.17.0/bin/node"


export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
