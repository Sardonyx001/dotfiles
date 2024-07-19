function pb --description "Uploads a file or data to a 0x0 paste bin service"

    # Init variables
    set -l VERSION "v2024.07.18"
    set -l ENDPOINT "https://0x0.st"
    set -l EXT ""
    set -l data ""

    function show_help
        echo "pb [options] filename"
        echo "or "
        echo "(command-with-stdout) | pb"
        echo ""
        echo "Uploads a file or data to the tilde 0x0 paste bin"
        echo ""
        echo "OPTIONAL FLAGS:"
        echo "  -h | --help)                    Show this help"
        echo "  -v | --version)                 Show current version number"
        echo "  -f | --file)                    Explicitly interpret stdin as filename"
        echo "  -c | --color)                   Pretty color output"
        echo "  -s | --server server_address)   Use alternative pastebin server address"
        echo "  -e | --extension bin_extension) Specify file extension used in the upload"
        echo ""
        echo "Example usage:"
        echo "  # Upload 'scores.txt' to the pastebin"
        echo "  pb scores.txt"
        echo "  # Upload piped output to the pastebin"
        echo "  echo 'Secret info' | pb"
        echo "  # Upload a list of javascript files to the pastebin individually"
        echo "  find . -type f -name '*.js' -print | pb -f"
        echo "  # Upload a file to a different pastebin endpoint"
        echo "  pb -s http://0x0.st scores.txt"
        echo "  #Re-upload an image from the web"
        echo "  curl -s https://i.imgur.com/GkxTZ3W.jpeg | pb -e 'jpeg' "
    end

    function show_usage
        echo "usage: pb [-hfvcux] [-s server_address] filename"
    end

    # Helper exit func, supports msgs and codes
    function die
        set msg $argv[1]
        set code (test (count $argv) -gt 1 && echo $argv[2] || echo 1)

        # output message to stdout or stderr based on code
        if test -n "$msg"
            if test $code -eq 0
                echo "$msg"
            else
                echo "$msg" >&2
            end
        end
        return $code
    end

    # Parse arguments
    argparse h/help v/version c/color f/file e/extension s/server -- $argv
    or return

    # Display current version
    if set -ql _flag_version
        echo "$VERSION"
        die "" 0
    end

    # Display help
    if set -ql _flag_help
        show_help
        die "" 0
    end

    # Set endpoint from flag
    if set -ql _flag_server
        set ENDPOINT $flag_server
    end

    # Colors
    if set -ql _flag_color
        set SUCCESS (tput setaf 190)
        set ERROR (tput setaf 196)
        set RESET (tput sgr0)
    else
        set SUCCESS ""
        set ERROR ""
        set RESET ""
    end

    # Is not interactive shell, use stdin
    if not test -t 0
        if set -ql _flag_extension
            # Pipe STDIN with cat since `</dev/null` doesn't work with fish
            # Refer to https://github.com/fish-shell/fish-shell/issues/206#issuecomment-428308434
            set result (cat | curl -sSF"file=@-;filename=null.$_flag_extension" "$ENDPOINT")
            die "$SUCCESS $result $RESET" 0
        else
            # Read from stdin
            read -zl _data
            set data $_data
        end
    end

    # If data variable is empty (not a pipe) use params as fallback
    if test -z "$data"
        set data $argv
    end

    # Check if file flag is set
    if set -ql _flag_file
        # file mode
        if test -z "$data"
            # If no data show error
            die "$ERROR Provide data to upload $RESET" 1
        else if not test -f "$data"
            # File not found with provided name
            die "$RESET $data $ERROR File not found. $RESET" 1
            # Attempt to split data string and upload each string as file
            for f in $data
                # Check if file exists
                if test -f "$f"
                    if set -ql _flag_extension
                        # Send file to endpoint masked with new extension
                        set result (curl -sSF"file=@$f;filename=null.$_flag_extension" "$ENDPOINT")
                    else
                        # Send file to endpoint
                        set result (curl -sSF"file=@$f" "$ENDPOINT")
                    end
                    die "$SUCCESS $result $RESET" 0
                else
                    die "$ERROR File not found. $RESET" 1
                end
            end
        else
            # Data available in file
            # Dend file to endpoint
            set result (curl -sSF"file=@$data" "$ENDPOINT")
            die "$SUCCESS $result $RESET" 0
        end
    else
        # Non-file mode
        if test -z "$data"
            # If no data print error
            die "$ERROR No data found for upload. Please try again. $RESET" 0
        else
            # Send data to endpoint
            set result (echo "$data" | curl -sSF"file=@-;filename=null.txt" "$ENDPOINT")
            die "$SUCCESS $result $RESET" 1
        end
    end
end
