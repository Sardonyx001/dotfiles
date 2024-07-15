function 4get -a THREADURL -a OUTPUTDIR --description 'Get all the pictures in a 4chan thread'
    if string-empty $THREADURL
        echo "Must provide a thread URL"
        return
    end

    if string-empty $OUTPUTDIR
        set OUTPUTDIR "."
    end
    mkdir -p $OUTPUTDIR

    set threadId $(echo $THREADURL | sed 's/.*\///g')
    set boardId $(echo $THREADURL | sed 's/.*org\///g' | sed 's/\/.*//g' )
    gum log -t kitchen -sl info "Downloading from" thread $threadId
    gum log -t kitchen -sl info "On " board $boardId
    gum log -t kitchen -sl info "To " output_dir $OUTPUTDIR
    curl -s "https://a.4cdn.org/$boardId/thread/$threadId.json" \
        | jq "
          .posts[] 
          | if .tim != null then 
             [.tim, .ext] 
            else empty 
            end 
          | map(tostring) 
          | \"https://i.4cdn.org/$boardId/\"+.[0]+.[1]" \
        | xargs -n 1 wget -P $OUTPUTDIR --no-verbose
end
