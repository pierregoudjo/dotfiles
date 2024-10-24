source ~/.zprofile
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

FPATH="${HOME}/.site-functions:${FPATH}"

autoload -Uz compinit
compinit
source "$HOME/.dotfiles/fzf-tab/fzf-tab.plugin.zsh"

export AWS_VAULT_KEYCHAIN_NAME=login

if type starship &>/dev/null
then
  eval "$(starship init zsh)"
fi

export PATH=$PATH:$HOME/bin
alias l="eza --icons=auto"
alias ll="eza --long --icons=auto"
alias lla="eza -a --long --icons=auto"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"

export BAT_THEME="Travertine"
export EZA_CONFIG_DIR="$XDG_CONFIG_HOME/eza"

function gi() { curl -sLw n https://www.toptal.com/developers/gitignore/api/$@ ;}
function my-public-ip { dig +short txt ch whoami.cloudflare @1.0.0.1 | jq -r}
function mcd() { mkdir $1; cd $1 }
autoload -U +X bashcompinit && bashcompinit

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

complete -o nospace -C /opt/homebrew/bin/terraform terraform

eval "$(zoxide init zsh)"

source <(fzf --zsh)

export SSH_AUTH_SOCK=/Users/pierre/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh

ZELLIJ_AUTO_EXIT="true"
if [[ -z "$TERMINUS_SUBLIME" ]]; then
  eval "$(zellij setup --generate-auto-start zsh)"
fi
