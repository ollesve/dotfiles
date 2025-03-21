
function git_branch() {
  git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

function folder() {
  basename "`pwd`"
}

function get_time() {
  date +%H:%0M
}

function shs() {
  source ~/.zshrc
}

COLOR_DEF=$'\e[0m'
COLOR_DIR=$'\e[38;5;197m]'
COLOR_GIT=$'\e[38;5;39m'
COLOR_TIME=$'\e[38;5;1000m'
setopt PROMPT_SUBST

export PROMPT='$(get_time) $(folder) $(git_branch)$ '
export EDITOR="code"

alias zshconfig="code ~/.zshrc"
alias gitconfig="code ~/.gitconfig"
alias sshconfig="code ~/.ssh/config"
alias pip="pip3"
alias python="python3"


source /Users/ollesvensson/.docker/init-bash.sh || true # Added by Docker Desktop
