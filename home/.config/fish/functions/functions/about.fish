function about
    set _command_path (which $argv)
    if test -n "$_command_path"
        ls -alF $_command_path
    else
        echo "Command is not found"
    end
end
