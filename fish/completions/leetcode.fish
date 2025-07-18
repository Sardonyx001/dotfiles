# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_leetcode_global_optspecs
	string join \n d/debug h/help V/version
end

function __fish_leetcode_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_leetcode_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_leetcode_using_subcommand
	set -l cmd (__fish_leetcode_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c leetcode -n "__fish_leetcode_needs_command" -s d -l debug -d 'debug mode'
complete -c leetcode -n "__fish_leetcode_needs_command" -s h -l help -d 'Print help'
complete -c leetcode -n "__fish_leetcode_needs_command" -s V -l version -d 'Print version'
complete -c leetcode -n "__fish_leetcode_needs_command" -f -a "data" -d 'Manage Cache'
complete -c leetcode -n "__fish_leetcode_needs_command" -f -a "d" -d 'Manage Cache'
complete -c leetcode -n "__fish_leetcode_needs_command" -f -a "edit" -d 'Edit question'
complete -c leetcode -n "__fish_leetcode_needs_command" -f -a "e" -d 'Edit question'
complete -c leetcode -n "__fish_leetcode_needs_command" -f -a "exec" -d 'Submit solution'
complete -c leetcode -n "__fish_leetcode_needs_command" -f -a "x" -d 'Submit solution'
complete -c leetcode -n "__fish_leetcode_needs_command" -f -a "list" -d 'List problems'
complete -c leetcode -n "__fish_leetcode_needs_command" -f -a "l" -d 'List problems'
complete -c leetcode -n "__fish_leetcode_needs_command" -f -a "pick" -d 'Pick a problem'
complete -c leetcode -n "__fish_leetcode_needs_command" -f -a "p" -d 'Pick a problem'
complete -c leetcode -n "__fish_leetcode_needs_command" -f -a "stat" -d 'Show simple chart about submissions'
complete -c leetcode -n "__fish_leetcode_needs_command" -f -a "s" -d 'Show simple chart about submissions'
complete -c leetcode -n "__fish_leetcode_needs_command" -f -a "test" -d 'Test a question'
complete -c leetcode -n "__fish_leetcode_needs_command" -f -a "t" -d 'Test a question'
complete -c leetcode -n "__fish_leetcode_needs_command" -f -a "completions" -d 'Generate shell Completions'
complete -c leetcode -n "__fish_leetcode_needs_command" -f -a "c" -d 'Generate shell Completions'
complete -c leetcode -n "__fish_leetcode_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c leetcode -n "__fish_leetcode_using_subcommand data" -s d -l delete -d 'Delete cache'
complete -c leetcode -n "__fish_leetcode_using_subcommand data" -s u -l update -d 'Update cache'
complete -c leetcode -n "__fish_leetcode_using_subcommand data" -s h -l help -d 'Print help'
complete -c leetcode -n "__fish_leetcode_using_subcommand d" -s d -l delete -d 'Delete cache'
complete -c leetcode -n "__fish_leetcode_using_subcommand d" -s u -l update -d 'Update cache'
complete -c leetcode -n "__fish_leetcode_using_subcommand d" -s h -l help -d 'Print help'
complete -c leetcode -n "__fish_leetcode_using_subcommand edit" -s l -l lang -d 'Edit with specific language' -r
complete -c leetcode -n "__fish_leetcode_using_subcommand edit" -s d -l daily -d 'Edit today\'s daily challenge'
complete -c leetcode -n "__fish_leetcode_using_subcommand edit" -s h -l help -d 'Print help'
complete -c leetcode -n "__fish_leetcode_using_subcommand e" -s l -l lang -d 'Edit with specific language' -r
complete -c leetcode -n "__fish_leetcode_using_subcommand e" -s d -l daily -d 'Edit today\'s daily challenge'
complete -c leetcode -n "__fish_leetcode_using_subcommand e" -s h -l help -d 'Print help'
complete -c leetcode -n "__fish_leetcode_using_subcommand exec" -s d -l daily -d 'Exec today\'s daily challenge'
complete -c leetcode -n "__fish_leetcode_using_subcommand exec" -s h -l help -d 'Print help'
complete -c leetcode -n "__fish_leetcode_using_subcommand x" -s d -l daily -d 'Exec today\'s daily challenge'
complete -c leetcode -n "__fish_leetcode_using_subcommand x" -s h -l help -d 'Print help'
complete -c leetcode -n "__fish_leetcode_using_subcommand list" -s c -l category -d 'Filter problems by category name [algorithms, database, shell, concurrency] ' -r
complete -c leetcode -n "__fish_leetcode_using_subcommand list" -s p -l plan -d 'Invoking python scripts to filter questions' -r
complete -c leetcode -n "__fish_leetcode_using_subcommand list" -s q -l query -d 'Filter questions by conditions: Uppercase means negative e = easy     E = m+h m = medium   M = e+h h = hard     H = e+m d = done     D = not done l = locked   L = not locked s = starred  S = not starred' -r
complete -c leetcode -n "__fish_leetcode_using_subcommand list" -s r -l range -d 'Filter questions by id range' -r
complete -c leetcode -n "__fish_leetcode_using_subcommand list" -s t -l tag -d 'Filter questions by tag' -r
complete -c leetcode -n "__fish_leetcode_using_subcommand list" -s s -l stat -d 'Show statistics of listed problems'
complete -c leetcode -n "__fish_leetcode_using_subcommand list" -s h -l help -d 'Print help'
complete -c leetcode -n "__fish_leetcode_using_subcommand l" -s c -l category -d 'Filter problems by category name [algorithms, database, shell, concurrency] ' -r
complete -c leetcode -n "__fish_leetcode_using_subcommand l" -s p -l plan -d 'Invoking python scripts to filter questions' -r
complete -c leetcode -n "__fish_leetcode_using_subcommand l" -s q -l query -d 'Filter questions by conditions: Uppercase means negative e = easy     E = m+h m = medium   M = e+h h = hard     H = e+m d = done     D = not done l = locked   L = not locked s = starred  S = not starred' -r
complete -c leetcode -n "__fish_leetcode_using_subcommand l" -s r -l range -d 'Filter questions by id range' -r
complete -c leetcode -n "__fish_leetcode_using_subcommand l" -s t -l tag -d 'Filter questions by tag' -r
complete -c leetcode -n "__fish_leetcode_using_subcommand l" -s s -l stat -d 'Show statistics of listed problems'
complete -c leetcode -n "__fish_leetcode_using_subcommand l" -s h -l help -d 'Print help'
complete -c leetcode -n "__fish_leetcode_using_subcommand pick" -s n -l name -d 'Problem name' -r
complete -c leetcode -n "__fish_leetcode_using_subcommand pick" -s p -l plan -d 'Invoking python scripts to filter questions' -r
complete -c leetcode -n "__fish_leetcode_using_subcommand pick" -s q -l query -d 'Filter questions by conditions: Uppercase means negative e = easy     E = m+h m = medium   M = e+h h = hard     H = e+m d = done     D = not done l = locked   L = not locked s = starred  S = not starred' -r
complete -c leetcode -n "__fish_leetcode_using_subcommand pick" -s t -l tag -d 'Filter questions by tag' -r
complete -c leetcode -n "__fish_leetcode_using_subcommand pick" -s d -l daily -d 'Pick today\'s daily challenge'
complete -c leetcode -n "__fish_leetcode_using_subcommand pick" -s h -l help -d 'Print help'
complete -c leetcode -n "__fish_leetcode_using_subcommand p" -s n -l name -d 'Problem name' -r
complete -c leetcode -n "__fish_leetcode_using_subcommand p" -s p -l plan -d 'Invoking python scripts to filter questions' -r
complete -c leetcode -n "__fish_leetcode_using_subcommand p" -s q -l query -d 'Filter questions by conditions: Uppercase means negative e = easy     E = m+h m = medium   M = e+h h = hard     H = e+m d = done     D = not done l = locked   L = not locked s = starred  S = not starred' -r
complete -c leetcode -n "__fish_leetcode_using_subcommand p" -s t -l tag -d 'Filter questions by tag' -r
complete -c leetcode -n "__fish_leetcode_using_subcommand p" -s d -l daily -d 'Pick today\'s daily challenge'
complete -c leetcode -n "__fish_leetcode_using_subcommand p" -s h -l help -d 'Print help'
complete -c leetcode -n "__fish_leetcode_using_subcommand stat" -s h -l help -d 'Print help'
complete -c leetcode -n "__fish_leetcode_using_subcommand s" -s h -l help -d 'Print help'
complete -c leetcode -n "__fish_leetcode_using_subcommand test" -s d -l daily -d 'Test today\'s daily challenge'
complete -c leetcode -n "__fish_leetcode_using_subcommand test" -s h -l help -d 'Print help'
complete -c leetcode -n "__fish_leetcode_using_subcommand t" -s d -l daily -d 'Test today\'s daily challenge'
complete -c leetcode -n "__fish_leetcode_using_subcommand t" -s h -l help -d 'Print help'
complete -c leetcode -n "__fish_leetcode_using_subcommand completions" -s h -l help -d 'Print help'
complete -c leetcode -n "__fish_leetcode_using_subcommand c" -s h -l help -d 'Print help'
complete -c leetcode -n "__fish_leetcode_using_subcommand help; and not __fish_seen_subcommand_from data edit exec list pick stat test completions help" -f -a "data" -d 'Manage Cache'
complete -c leetcode -n "__fish_leetcode_using_subcommand help; and not __fish_seen_subcommand_from data edit exec list pick stat test completions help" -f -a "edit" -d 'Edit question'
complete -c leetcode -n "__fish_leetcode_using_subcommand help; and not __fish_seen_subcommand_from data edit exec list pick stat test completions help" -f -a "exec" -d 'Submit solution'
complete -c leetcode -n "__fish_leetcode_using_subcommand help; and not __fish_seen_subcommand_from data edit exec list pick stat test completions help" -f -a "list" -d 'List problems'
complete -c leetcode -n "__fish_leetcode_using_subcommand help; and not __fish_seen_subcommand_from data edit exec list pick stat test completions help" -f -a "pick" -d 'Pick a problem'
complete -c leetcode -n "__fish_leetcode_using_subcommand help; and not __fish_seen_subcommand_from data edit exec list pick stat test completions help" -f -a "stat" -d 'Show simple chart about submissions'
complete -c leetcode -n "__fish_leetcode_using_subcommand help; and not __fish_seen_subcommand_from data edit exec list pick stat test completions help" -f -a "test" -d 'Test a question'
complete -c leetcode -n "__fish_leetcode_using_subcommand help; and not __fish_seen_subcommand_from data edit exec list pick stat test completions help" -f -a "completions" -d 'Generate shell Completions'
complete -c leetcode -n "__fish_leetcode_using_subcommand help; and not __fish_seen_subcommand_from data edit exec list pick stat test completions help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'

