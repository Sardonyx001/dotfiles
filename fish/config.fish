# ------------- TMUX --------------------#
# if status is-interactive
# end

# ------------  Virtual Environment ------#
# Set up Java virtual environment (jenv)
# status --is-interactive; and jenv init - | source

# Load aliases
if [ -f $HOME/.config/fish/alias.fish ]
    source $HOME/.config/fish/alias.fish
end


# Bind ranger's current directory to shell env
bind \co ranger-cd

# -------- Shell Integrations -----------#

# pnpm
set -gx PNPM_HOME /Users/jam/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# bun
set -gx BUN_INSTALL "$HOME/.bun"

# zoxide (`z`) 
zoxide init fish | source

# fzf 
fzf --fish | source

# iterm2 
source ~/.config/fish/.iterm2_shell_integration.fish

# Homebrew config 
export HOMEBREW_NO_AUTO_UPDATE=1

# Spotify mod
fish_add_path /Users/jam/.spicetify

# Don't build docker images with macos architecture
set -gx DOCKER_DEFAULT_PLATFORM linux/amd64
set -gx DOCKER_SCAN_SUGGEST false

# Set neovim as default editor
set -gx EDITOR nvim
set -gx HOMEBREW_EDITOR code
set -gx BAT_PAGER "ov --quit-if-one-screen -F -H3"
set -gx BAT_THEME gruvbox-dark
set -gx ANDROID_NDK_HOME /opt/homebrew/share/android-ndk
set -gx CHARM_HOST "jamell.dev"
set -gx GPG_TTY (tty)
set -Ux GOPATH (go env GOPATH)

# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish


# Keep at the bottom
starship init fish | source
