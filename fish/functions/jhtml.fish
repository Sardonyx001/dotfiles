function jhtml --description 'Decode HTML escaped Japanese characters'
    if test (count $argv) -eq 0
        echo "Usage: jhtml <encoded_string>"
        return 1
    end

    set encoded_string $argv[1]

    set decoded_string (echo $encoded_string | python3 -c "import sys, html; print(html.unescape(sys.stdin.read()))")

    echo $decoded_string
end
