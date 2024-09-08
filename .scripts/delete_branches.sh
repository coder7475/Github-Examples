#!/bin/bash

# Array of branches to keep
KEEP_BRANCHES=("main" "development" "staging")

echo "Fetching latest changes from remote..."
git fetch --all --prune

echo "Deleting local branches..."
git branch | grep -v -E "$(IFS=\|; echo "${KEEP_BRANCHES[*]}")" | xargs -r git branch -D

echo "Deleting remote branches..."
git branch -r | grep -v -E "$(IFS=\|; echo "${KEEP_BRANCHES[*]}")" | sed 's/origin\///' | xargs -r -I {} git push origin :{}

echo "Pruning remote branches..."
git remote prune origin

echo "Branch cleanup complete."