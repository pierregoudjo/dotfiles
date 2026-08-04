source ~/.zprofile
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

FPATH="${HOME}/.site-functions:${FPATH}"

autoload -Uz compinit
compinit
source "$HOME/.dotfiles/fzf-tab/fzf-tab.plugin.zsh"

source "$(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"

source "$(brew --prefix)/share/zsh-autopair/autopair.zsh"

if type starship &>/dev/null
then
  eval "$(starship init zsh)"
fi

export PATH=$PATH:$HOME/bin
alias l="eza --icons=auto"
alias ll="eza --long --icons=auto"
alias lla="eza -a --long --icons=auto"
alias -g P='| pe | fzf | read filename; [ ! -z $filename ] && nvim $filename'
alias awslocal="aws --endpoint-url http://localhost:4566"
alias mcat='mcat -t makurai_light'
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"

export BAT_THEME="Travertine"
export EZA_CONFIG_DIR="$XDG_CONFIG_HOME/eza"
export EDITOR=nvim

function gi() { curl -sLw n https://www.toptal.com/developers/gitignore/api/$@ ;}
function my-public-ip { dig +short txt ch whoami.cloudflare @1.0.0.1 | jq -r}
autoload -U +X bashcompinit && bashcompinit

complete -o nospace -C /opt/homebrew/bin/terraform terraform

eval "$(zoxide init --cmd=cd zsh)"

source <(fzf --zsh)

export SSH_AUTH_SOCK=$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh

function zvm_vi_yank() {
	zvm_yank
	echo ${CUTBUFFER} | pbcopy
	zvm_exit_visual_mode
}

# Load additional scripts if they exists
if [ -f "$HOME/.zsh_extras" ]; then
  source "$HOME/.zsh_extras"
fi

export JAVA_TOOL_OPTIONS="-Djavax.net.ssl.trustStore=/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home/lib/security/cacerts"

eval "$(mise activate zsh)"
# Loop through all files in the ~/.config/fabric/patterns directory
for pattern_file in $HOME/.config/fabric/patterns/*; do
    # Get the base name of the file (i.e., remove the directory path)
    pattern_name="$(basename "$pattern_file")"
    alias_name="${FABRIC_ALIAS_PREFIX:-}${pattern_name}"

    # Create an alias in the form: alias pattern_name="fabric --pattern pattern_name"
    alias_command="alias $alias_name='fabric --pattern $pattern_name'"

    # Evaluate the alias command to add it to the current shell
    eval "$alias_command"
done

yt() {
    if [ "$#" -eq 0 ] || [ "$#" -gt 2 ]; then
        echo "Usage: yt [-t | --timestamps] youtube-link"
        echo "Use the '-t' flag to get the transcript with timestamps."
        return 1
    fi

    transcript_flag="--transcript"
    if [ "$1" = "-t" ] || [ "$1" = "--timestamps" ]; then
        transcript_flag="--transcript-with-timestamps"
        shift
    fi
    local video_link="$1"
    fabric -y "$video_link" $transcript_flag
}
