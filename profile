# TODO: Clean this up

export EDITOR="code" 
# export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export ZSH="~/.oh-my-zsh"
ZSH_THEME="fwalch"

alias zshconfig="nano ~/.zshrc"
alias gitconfig="nano ~/.gitconfig"
alias sshconfig="nano ~/.ssh/config"
alias ocopen=alias ocw=$'oc project -q | awk \'{printf("https://console.prod.bonniernews.io/console/project/%s", $1)}\' | xargs open'

# Load Git completion NOT WORKING?
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit