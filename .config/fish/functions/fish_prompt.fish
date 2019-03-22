function fish_prompt --description 'Write out the prompt'
	set -l last_status $status

    echo
    # User
    set_color brcyan
    echo -n (whoami)
    set_color brgreen

    echo -n '@'

    # Host
    echo -n (prompt_hostname | string split '-')[1]
    set_color brmagenta

    echo -n ' '

    echo -n (fish -v | sed -e 's/, version /:/g')

    # PWD
    set_color bryellow
    echo -n ' '
    echo -n (dirs)
    set_color normal

    __terlar_git_prompt
    __fish_hg_prompt
    echo

    if not test $last_status -eq 0
        set_color $fish_color_error
    end

    echo -n '$ '
    set_color normal
end
