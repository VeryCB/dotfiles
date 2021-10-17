#!/bin/sh

echo "Generating a new SSH key for GitHub..."

# Generating a new SSH key
# https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key
ssh-keygen -t ed25519 -C $1 -f ~/.ssh/id_ed25519_verycb

# Adding your SSH key to the ssh-agent
# https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent
eval "$(ssh-agent -s)"

touch ~/.ssh/config
echo "Host github.com\n HostName github.com\n IdentityFile ~/.ssh/id_ed25519_verycb\n IdentitiesOnly yes" | tee ~/.ssh/config

ssh-add -K ~/.ssh/id_ed25519_verycb

ssh-keygen -t ed25519 -C $2 -f ~/.ssh/id_ed25519_shepeth

eval "$(ssh-agent -s)"

echo "Host github-shepeth\n HostName github.com\n IdentityFile ~/.ssh/id_ed25519_shepeth\n IdentitiesOnly yes" | tee ~/.ssh/config

ssh-add -K ~/.ssh/id_ed25519_shepeth

# Adding your SSH key to your GitHub account
# https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account
echo "run 'pbcopy < ~/.ssh/id_ed25519_verycb.pub' and 'pbcopy < ~/.ssh/id_ed25519_shepeth.pub', paste them into seperate GitHub accounts"

