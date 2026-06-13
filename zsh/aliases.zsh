# actions
alias zshreload='source ~/.zshrc'
alias grep='grep --color=auto'
alias less='less -R'
alias e='exit'
alias lsl="lsd --tree -l"

# paths
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias temp='~/Documents/temp'
alias dev='~/dev'
alias htdocs='~/../../Applications/MAMP/htdocs'
alias wpl='~/Local\ Sites'
alias config='~/.config'
alias hconf='~/.config/hypr/'
alias nconf='~/.config/nvim/'

# git
alias g='git'
alias gA='git add -A'
alias gc='git commit -m'
alias gp='git push'
alias gpo='git pull origin'
alias gs='git status'
alias gsc='git switch -c'
alias gdel='git branch -d'

# misc
alias t='tmux'
alias tdev="$HOME/.config/tmux/layouts/dev.sh"
alias n='nvim'
alias m='mullvad'
alias weather="curl v2.wttr.in/${1:-Vancouver} --silent | less -S -R -#3"
alias cc='claude'
alias cx='codex'
alias theme='~/bin/toggle-theme'

