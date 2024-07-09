function loc -d "Count the number of lines in a remote Git repository"
  git clone --depth 1 "$argv[1]" temp-linecount-repo
  printf "('temp-linecount-repo' will be deleted automatically)\n\n\n" 
  cloc temp-linecount-repo
  trash temp-linecount-repo
end
