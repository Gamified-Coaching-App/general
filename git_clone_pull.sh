#!/bin/bash

# Define the organization name
ORG_NAME="Gamified-Coaching-App"
# Define your personal access token
ACCESS_TOKEN="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"

# Function to clone or pull repositories
clone_or_pull() {
    local REPO_URL="$1" # Here $1 represents the first argument passed to the function
    local REPO_NAME=$(basename "$REPO_URL" .git)

    # Check if the repository directory already exists
    if [ -d "$REPO_NAME" ]; then
        # If the directory exists, perform a git pull
        echo "Pulling changes for $REPO_NAME..."
        cd "$REPO_NAME" || exit
        git pull
        cd ..
    else
        # If the directory doesn't exist, clone the repository using SSH
        echo "Cloning $REPO_NAME..."
        git clone "$REPO_URL"
    fi
}

# Get a list of repositories in the organization using SSH clone URLs
REPOS_URL="git@github.com:$ORG_NAME"
REPO_URLS=$(curl -s "https://api.github.com/orgs/$ORG_NAME/repos" | jq -r '.[].ssh_url')

# Iterate over each repository URL and clone or pull
for REPO_URL in $REPO_URLS; do
    clone_or_pull "$REPO_URL"
done
