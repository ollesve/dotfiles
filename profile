# TODO: Clean this up
# export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

function git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

function folder() {
 basename "`pwd`"
}

function time() {
 basename "`pwd`"
}

COLOR_DEF=$'\e[0m'
COLOR_DIR=$'\e[38;5;197m'
COLOR_GIT=$'\e[38;5;39m'
COLOR_TIME=$'\e[38;5;39m'
setopt PROMPT_SUBST

export PROMPT='${COLOR_DIR}$(folder) ${COLOR_GIT}$(git_branch)${COLOR_DEF} $ '
export EDITOR="code"

alias zshconfig="nano ~/.zshrc"
alias gitconfig="nano ~/.gitconfig"
alias sshconfig="nano ~/.ssh/config"

# Load Git completion NOT WORKING?
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit
