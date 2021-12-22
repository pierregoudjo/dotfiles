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
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"





