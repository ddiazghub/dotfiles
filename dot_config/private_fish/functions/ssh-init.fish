function ssh-init -d "Initialize SSH agent and set a credential for the current session"
    # Open an FZF picker with a list of ssh keys
    set selected (
        exa -1 --color=always ~/.ssh/*.pub \
            | awk -v home="$HOME/" '{sub(home, "~/"); print "🔑  " $0}' \
            | fzf --ansi \
                --tmux "center" \
                --preview 'bat --color=always --style=plain (string replace "~" $HOME -- (string split " " {} | tail -n 1))' \
                --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
                --prompt="SSH keys > " \
                --info=inline
   )

    # If nothing selected, exit quietly
    if test -z "$selected"
        return 0
    end

    # Clean up: strip ANSI colors, get last field (the path), expand ~, strip .pub
    set privpath (printf '%s\n' "$selected" \
        | perl -pe 's/\e\[[0-9;]*[a-zA-Z]//g' \
        | awk '{print $NF}' \
        | sed "s|^~|$HOME|" \
        | sed 's/\.pub$//')

    # Verify file exists and add it to agent
    if test -f "$privpath"
        eval (ssh-agent -c) # Initialize agent if needed
        ssh-add "$privpath"

        if test $status -eq 0
            echo "✅ Added key: $selected"
        else
            echo "❗ ssh-add failed for: $privpath" >&2
            return 1
        end
    else
        echo "❗ Private key not found: $privpath" >&2
        return 1
    end
end
