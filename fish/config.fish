# Disable fish greeting
set -U fish_greeting

# Load aliases
if [ -f $HOME/.config/fish/alias.fish ]
    source $HOME/.config/fish/alias.fish
end

# -------- Shell Integrations -----------#

# jenv
# status --is-interactive; and jenv init - | source

# pnpm
set -gx PNPM_HOME /Users/jam/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end

# completions and integrations
zoxide init fish | source
fx --comp fish | source
fzf --fish | source
pyenv init - | source
aegis completion fish | source
source ~/.config/fish/.iterm2_shell_integration.fish

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
set -gx BAT_THEME gruvbox-dark
set -gx ANDROID_NDK_HOME /opt/homebrew/share/android-ndk
set -gx GPG_TTY (tty)
set -Ux GOPATH (go env GOPATH)
set -gx BW_SESSION "ZeAmaxfOBhXIKj3YLpW0YOpq3WDqdf9cCFzjaObebWIavzHrjIk6riNpap2amby0KVsacgt3EJGTpTvqY8z3zw=="

# Keep at the bottom
starship init fish | source
