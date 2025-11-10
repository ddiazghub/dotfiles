if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_key_bindings fish_vi_key_bindings
end

fish_config theme choose ayu\ Dark
starship init fish | source
zoxide init fish | source
fzf --fish | source

set -x MANPAGER 'nvim +Man!'

alias cd=z
alias ls="exa -lh --icons --git"
alias la="ls -aa"
alias du="dust"
alias ps="procs"
alias df="duf"
