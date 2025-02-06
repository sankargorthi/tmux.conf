#!/bin/sh

# Move into the correct directory (current tmux pane path)
cd "$(tmux display -p '#{pane_current_path}')" || exit 1

# Get the current branch name
branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

if [ -z "$branch" ]; then
    exit 0  # Not a Git repo, output nothing
fi

# Detect Git status
status=$(git status --porcelain 2>/dev/null)

# Set default icon
icon=""

# Add status indicators
if echo "$status" | grep -q '^ M'; then
    icon=" $icon"   # Modified files
elif echo "$status" | grep -q '^A\|^M\|^D'; then
    icon=" $icon"   # Staged files
elif echo "$status" | grep -q '^??'; then
    icon=" $icon"   # untracked files
fi

# Output the final status line
echo "$icon $branch"
