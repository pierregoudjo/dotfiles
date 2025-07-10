# Pierre's dotfiles
## What is this
This repository helps me setup and maintain my workstation. It takes the effort out of installing everything manually. 

These dotfiles are hugely influenced by @driesvints [dotfiles](https://github.com/driesvints/dotfiles/tree/f6321eed4852578c5c23894dcb22814851efd8d1)

## Installation

- Clone this repo to `~/.dotfiles`
- Fetch all the submodules: `git submodule update --init --recursive`
- Run `install.sh` to start the installation
- Set zsh as your default shell: `chsh -s $(which zsh)`
- Reload your environment with `source ~/.zshrc`

## Additional steps (Optional)
### Configure icloud email

- Create an app-specific password on your [ Apple Account ](https://account.apple.com/). Take note of the generated password for the next steps.
- Run the "set_icloud_informations.sh" command to store email informations. Input your iCloud username, the app-specific password and your email address when prompted.
- Run the `get_encrypted_value_from_keychain.sh` command to generate the aerc `accounts.conf` file

### Set up vdirsyncer

- Run `vdirsyncer discover` command to discover the ics and vcard collections
- Run `vdirsyncer sync` to pull the calendars and contacts locally

## Check the code

See the [install.sh](install.sh)
