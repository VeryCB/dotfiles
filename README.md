# dotfiles

Setup and maintain my Mac.

## Checklist before re-install

* Commit and push any changes/branches to git repositories
* Backup all important files from non-iCloud/non-Dropbox directories
* Backup important data from local databases

## Bootstrap
1. Signin to Mac App Store and update macOS to the latest version
2. Generate a new SSH key:
   ```zsh
   curl https://raw.githubusercontent.com/verycb/dotfiles/HEAD/ssh.sh | sh -s "<your-email-address>"
   ```
3. Clone this repo to `~/Dotfiles` with:

    ```zsh
    git clone git@github.com:verycb/dotfiles.git ~/Dotfiles
    ```
4. Run the bootstrap scriptwith:

    ```zsh
    cd ~/Dotfiles && source bootstrap.sh
    ```
5. Restart the computer to finalize the process

Enjoy :)
