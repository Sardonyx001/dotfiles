function pw --wraps='gokey -p ~/.gokey-master -r $(openssl rand -base64 12) -t pass -l 12' --description 'alias pw=gokey -p ~/.gokey-master -r $(openssl rand -base64 12) -t pass -l 12'

    set realm (openssl rand -base64 12)
    if not string-empty $argv
        set realm $argv[1]
    end

    set len 12
    if not string-empty $argv[2]
        set len $argv[2]
    end

    gokey -p ~/.gokey-master -r $realm -t pass -l $len
end
