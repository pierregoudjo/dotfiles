




if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

export AWS_VAULT_KEYCHAIN_NAME=login

if test $(which starship); then
eval "$(starship init zsh)"
fi


eval "$(cat $HOME/.site-functions/aws-vault)"

export PATH=$PATH:$HOME/bin
alias l="exa"
alias ll="exa --long"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"





