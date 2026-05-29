export XDG_CONFIG_HOME="$HOME/.config"
export ZSH="$HOME/.oh-my-zsh"

export PATH="\
$HOME/.config/composer/vendor/bin:\
/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:\
$HOME/.local/bin"

# --- go ---
export GOPATH="$HOME/go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"

# --- rbenv ---
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

# --- pyenv ---
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# --- nvm ---
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# --- postgres ---
export PGDATA="$HOME/Documents/postgres/"

# --- envman ---
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# --- zsh/omz ---
plugins=(git zsh-autosuggestions shrink-path nvm)
source $ZSH/oh-my-zsh.sh

# --- history ---
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS

# --- local config ---
source $XDG_CONFIG_HOME/zsh/env.zsh
source $XDG_CONFIG_HOME/zsh/aliases.zsh

eval "$(starship init zsh)"
