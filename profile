
function git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

function folder() {
 basename "`pwd`"
}

function time() {
 basename "`pwd`"
}

function zshu() {
 source ~/.profile
 source ~/.zshrc
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
