function pxml --description "Pretty print XML files"
    if test (count $argv) -ne 1
        echo "Usage: pxml <file.xml>"
        return 1
    end

    if not test -f $argv[1]
        echo "File not found: $argv[1]"
        return 1
    end

    # Use `cat` if `bat` is not installed
    set -l bat_cmd (command -v bat)
    if test -z "$bat_cmd"
        set -l bat_cmd cat
    end

    python3 -c "import sys; from xml.dom.minidom import parse; print('\n'.join([line for line in parse(sys.stdin).toprettyxml().split('\n') if line.strip()]))" <$argv[1] | $bat_cmd
end
