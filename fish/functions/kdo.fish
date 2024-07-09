function kdo --wraps=ps\ ax\ \|\ grep\ -i\ docker\ \|\ egrep\ -iv\ \'grep\|com.docker.vmnetd\'\ \|\ awk\ \'\{print\ \}\'\ \|\ xargs\ kill --description alias\ kdo=ps\ ax\ \|\ grep\ -i\ docker\ \|\ egrep\ -iv\ \'grep\|com.docker.vmnetd\'\ \|\ awk\ \'\{print\ \}\'\ \|\ xargs\ kill
  ps ax | grep -i docker | egrep -iv 'grep|com.docker.vmnetd' | awk '{print }' | xargs kill $argv
        
end
