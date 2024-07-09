function cdl --wraps=cd --description 'Cd and ls into a dir'
    cd "$argv" && eza -lhg
end
