function badge
    /bin/bash -c 'printf "\e]1337;SetBadgeFormat=%s\a"    $(echo -n '$argv' | base64)'
end