[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

export ZSH="$HOME/.oh-my-zsh"
export XDG_CONFIG_HOME="$HOME/.config"
# export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:$PATH"
export PATH="$HOME/.config/composer/vendor/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:$HOME/go/bin:$HOME/.local/bin/"
export PGDATA="$HOME/Documents/postgres/"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

source $XDG_CONFIG_HOME/zsh/env.zsh

# ignore commands with leading space in history
setopt HIST_IGNORE_SPACE

# do not store duplicate commands
setopt HIST_IGNORE_DUPS

# do not store lines starting with space *or* duplicates
setopt HIST_IGNORE_ALL_DUPS

# plugins
plugins=(git zsh-autosuggestions shrink-path nvm)

source $ZSH/oh-my-zsh.sh

source $XDG_CONFIG_HOME/zsh/aliases.zsh

eval "$(starship init zsh)"
