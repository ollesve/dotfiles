# Git worktree helpers.
#
#   wt <branch>     create a worktree from origin/main and open it in a new
#                   VS Code window (the current terminal stays put)
#   wt-done         remove the worktree you're standing in
#   wt-list         list all worktrees for the current repo
#   wt-cd <query>   cd to a worktree whose path matches <query>
#
# Worktrees are created under $WT_ROOT (default ~/worktree). Override in your
# environment to move them elsewhere, e.g.  export WT_ROOT=/worktree

WT_ROOT="${WT_ROOT:-$HOME/worktree}"

# wt <branch> — create <branch> off a freshly fetched origin/main in a new
# worktree at $WT_ROOT/<branch-with-slashes-as-dashes> and open it in a new
# VS Code window. The calling terminal stays in its current directory.
# If <branch> already exists locally it is checked out instead of recreated.
wt() {
  emulate -L zsh
  local branch="$1"
  if [[ -z "$branch" ]]; then
    print -u2 "usage: wt <branch>        e.g. wt feat/branch-name"
    return 1
  fi

  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    print -u2 "wt: not inside a git repository"
    return 1
  fi

  local dirname="${branch//\//-}"        # feat/branch-name -> feat-branch-name
  local dest="$WT_ROOT/$dirname"

  if [[ -e "$dest" ]]; then
    print -u2 "wt: $dest already exists"
    return 1
  fi

  mkdir -p "$WT_ROOT" || return 1

  print "wt: fetching origin/main…"
  git fetch origin main || return 1

  if git show-ref --verify --quiet "refs/heads/$branch"; then
    print "wt: branch '$branch' exists — adding worktree at $dest"
    git worktree add "$dest" "$branch" || return 1
  else
    print "wt: creating '$branch' from origin/main at $dest"
    git worktree add -b "$branch" "$dest" origin/main || return 1
  fi

  print "wt: created '$branch' at $dest"

  # Open the new worktree in a fresh VS Code window (if `code` is on PATH).
  # The calling terminal deliberately stays where it is — work in the new window.
  if command -v code >/dev/null 2>&1; then
    code -n "$dest"
  fi
}

# wt-done — remove the worktree you're currently in and return to the main
# worktree. Deletes the branch only if it has been merged (safe git branch -d).
# Refuses to remove the repo's main worktree.
wt-done() {
  emulate -L zsh
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    print -u2 "wt-done: not inside a git repository"
    return 1
  fi

  local current main_wt branch
  current="$(git rev-parse --show-toplevel)" || return 1
  main_wt="$(git worktree list --porcelain | awk '/^worktree /{print $2; exit}')"
  branch="$(git symbolic-ref --quiet --short HEAD 2>/dev/null)"

  if [[ "$current" == "$main_wt" ]]; then
    print -u2 "wt-done: refusing to remove the main worktree ($current)"
    return 1
  fi

  # Step out of the directory before removing it.
  cd "$main_wt" || return 1

  print "wt-done: removing worktree $current"
  if ! git worktree remove "$current"; then
    print -u2 "wt-done: worktree has uncommitted changes."
    print -u2 "         discard them with: git worktree remove --force '$current'"
    cd "$current"   # put the user back where they were
    return 1
  fi

  if [[ -n "$branch" ]]; then
    if git branch -d "$branch" 2>/dev/null; then
      print "wt-done: deleted merged branch '$branch'"
    else
      print "wt-done: kept unmerged branch '$branch' — delete with: git branch -D $branch"
    fi
  fi

  print "wt-done: now in $main_wt"
}

# wt-list — show all worktrees for the current repo.
wt-list() {
  git worktree list
}

# wt-cd <query> — cd to the first worktree whose path matches <query>.
wt-cd() {
  emulate -L zsh
  local query="$1" dest
  if [[ -z "$query" ]]; then
    print -u2 "usage: wt-cd <query>"
    return 1
  fi
  dest="$(git worktree list --porcelain | awk '/^worktree /{print $2}' | grep -i -- "$query" | head -1)"
  if [[ -z "$dest" ]]; then
    print -u2 "wt-cd: no worktree matching '$query'"
    return 1
  fi
  cd "$dest"
}
