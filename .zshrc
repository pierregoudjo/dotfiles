source ~/.zprofile
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

FPATH="${HOME}/.site-functions:${FPATH}"

autoload -Uz compinit
compinit

export AWS_VAULT_KEYCHAIN_NAME=login

if type starship &>/dev/null
then
  eval "$(starship init zsh)"
fi

export PATH=$PATH:$HOME/bin
alias l="exa"
alias ll="exa --long"
alias lla="exa -a --long"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"

export BAT_THEME="ansi"




function gi() { curl -sLw n https://www.toptal.com/developers/gitignore/api/$@ ;}

function my-public-ip { dig +short txt ch whoami.cloudflare @1.0.0.1 | jq -r}
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

complete -o nospace -C /opt/homebrew/bin/terraform terraform
