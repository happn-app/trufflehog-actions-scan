#!/usr/bin/env sh
set -eu

LOGFILE=trufflehog_results.txt

# Redirect ANY output from this script to "$LOGFILE"
exec 1<&-;          exec 2<&-
exec 1<>"$LOGFILE"; exec 2>&1

# Default trufflehog options
args="--regex --entropy=False --max_depth=50 --json"

if [ -n "${INPUT_SCANARGUMENTS}" ]; then
  args="${INPUT_SCANARGUMENTS}" # Overwrite if new options string is provided
fi

if [ -n "${INPUT_GITHUBTOKEN}" ]; then
  # Overwrite for private repository if token provided
  githubRepo="https:///x-access-token:$INPUT_GITHUBTOKEN@github.com/$GITHUB_REPOSITORY.git"
else
  githubRepo="https://github.com/$GITHUB_REPOSITORY" # Default target repository
fi

query="$args $githubRepo" # Build args query with repository url
trufflehog $query >./trufflehog_results.txt 2>&1
