#!/bin/sh

echo "Generating a new SSH key for GitHub..."

ssh-keygen -t ed25519 -C $1 -f ~/.ssh/id_ed25519_verycb
eval "$(ssh-agent -s)"
ssh-add -K ~/.ssh/id_ed25519_verycb

ssh-keygen -t ed25519 -C $2 -f ~/.ssh/id_ed25519_shepeth
eval "$(ssh-agent -s)"
ssh-add -K ~/.ssh/id_ed25519_shepeth

cp ./ssh/config ~/.ssh

echo "run 'pbcopy < ~/.ssh/id_ed25519_verycb.pub' and 'pbcopy < ~/.ssh/id_ed25519_shepeth.pub', paste them into seperate GitHub accounts"
