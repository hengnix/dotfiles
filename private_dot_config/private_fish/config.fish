set -gx LANG zh_CN.UTF-8

if status is-interactive
    set fish_greeting ""

    alias hx='command helix'
    alias zj='command zellij'

    function yy
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

    zoxide init fish | source
end

# vm_envs start
if not test $VM_DISABLE
    . ~/.vmr/vmr.fish
end
# vm_envs end
