function abr --description 'Adds a new abbreviation and sources the alias file'
    if test (count $argv) -ne 2
        echo "Usage: abr <abbr> <expression>"
        echo "Example: abr ec 'echo hello'"
        return 1
    end
    echo abbr $argv[1] \'$argv[2]\' >>~/.config/fish/alias.fish
    source ~/.config/fish/alias.fish
end
