# ------------- TMUX --------------------#
# if status is-interactive
# end

# ------------  THEMES ------------------#
# Set up starship theme

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
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

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
set --universal --export DOCKER_DEFAULT_PLATFORM linux/amd64
set --universal --export DOCKER_SCAN_SUGGEST false

# Set neovim as default editor
set --universal --export EDITOR nvim
set --universal --export HOMEBREW_EDITOR code
set --universal --export BAT_PAGER "ov --quit-if-one-screen -F -H3"
set --universal --export BAT_THEME gruvbox-dark
set --universal --export ANDROID_NDK_HOME /opt/homebrew/share/android-ndk
set --universal --export CHARM_HOST jamell.dev

# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish


# Keep at the bottom
starship init fish | source
