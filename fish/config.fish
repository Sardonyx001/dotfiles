# Disable fish greeting
set -U fish_greeting

# Load aliases
if [ -f $HOME/.config/fish/alias.fish ]
    source $HOME/.config/fish/alias.fish
end

# -------- Shell Integrations -----------#

# jenv
status --is-interactive; and jenv init - | source

# pnpm
set -gx PNPM_HOME $HOME/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end

# completions and integrations
source "$HOME/.cargo/env.fish"
zoxide init fish | source
fx --comp fish | source
fzf --fish | source
# pyenv init - | source

# Don't build docker images with macos architecture
set -gx DOCKER_DEFAULT_PLATFORM linux/amd64
set -gx DOCKER_SCAN_SUGGEST false

# Set neovim as default editor
set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -Ux FZF_DEFAULT_COMMAND "fd -H -E '.git'"
set -Ux PAGER nvimpager
set -gx MANPAGER "vim +MANPAGER -"
set -gx HOMEBREW_NO_AUTO_UPDATE 1
set -gx HOMEBREW_EDITOR code
set -gx BUN_INSTALL "$HOME/.bun"
set -gx PATH $BUN_INSTALL/bin $PATH
set -gx BAT_THEME gruvbox-dark
set -gx ANDROID_NDK_HOME /opt/homebrew/share/android-ndk
set -gx GPG_TTY (tty)
set -Ux GOPATH $HOME/go
set -gx BW_SESSION "d1m7aN77B3jQ2GV3Da2v0ON3JiYKXHgD0IndfuoDmwy1b1z/Ntrq/epR8zgscT3QKeaAAJH8+iSsYoymYcQOpg=="

# Set custom Root CA Bundle for Netskope (Intra network)
set -gx CURL_CA_BUNDLE "/Library/Application Support/Netskope/STAgent/data/nscacert_combined.pem"
set -gx NODE_EXTRA_CA_CERTS "/Library/ApplicationSupport/Netskope/STAgent/data/nscacert_combined.pem"
set -gx REQUESTS_CA_BUNDLE "/Library/Application Support/Netskope/STAgent/data/nscacert_combined.pem"

# Keep at the bottom
starship init fish | source
