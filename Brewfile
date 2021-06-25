tap 'homebrew/cask'
tap 'homebrew/cask-fonts'
tap 'homebrew/cask-versions'
tap 'homebrew/bundle'
tap 'homebrew/core'
tap 'homebrew/services'
tap 'universal-ctags/universal-ctags'

# System
brew 'universal-ctags', args: ['HEAD']
brew 'git'
brew 'openssl'
brew 'the_silver_searcher'
brew 'tmux'
brew 'vim'
brew 'zsh'
brew 'htop'
brew 'tree'
brew 'mas'

# Programming language prerequisites and package managers
brew 'libyaml' # should come after openssl
brew 'coreutils'
brew 'yarn'
cask 'gpg-suite'

# Common Apps
cask 'iterm2'
cask 'google-chrome'
cask '1password'
cask '1password-cli'
cask 'dropbox'
cask 'spectacle'
cask 'wechat'
cask 'discord'
cask 'telegram'

# Databases
brew 'postgres', restart_service: :changed
brew 'redis', restart_service: :changed

# Mac App Store
mas 'Bear', id: 1091189122
