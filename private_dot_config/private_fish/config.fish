set -gx LANG zh_CN.UTF-8

fish_add_path --global ~/.bun/bin

fish_vi_key_bindings

if status is-interactive
    set fish_greeting ""

    alias hx='command helix'
    alias zj='command zellij'
    alias svmr="export VM_DISABLE='' && source /home/heng/.config/fish/config.fish"

    function y
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
