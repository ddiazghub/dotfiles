#!/usr/bin/env bash

# Clipboard manager with fzf preview in a floating terminal
# Dependencies: cliphist, fzf, chafa (for images), wl-copy, ghostty

# Launch in floating terminal if not already inside one
if [[ -z "$CLIPBOARD_FZF_INNER" ]]; then
    export CLIPBOARD_FZF_INNER=1
    ghostty --title="Clipboard Manager" --command="$0"
    exit 0
fi

# Preview script
preview() {
    local tmp_file="/tmp/clipboard_preview_$$"

    # Handle input from argument or stdin
    if [[ "$1" == "/dev/stdin" ]]; then
        cat | cliphist decode > "$tmp_file" 2>/dev/null
    else
        echo "$@" | cliphist decode > "$tmp_file" 2>/dev/null
    fi

    local filetype
    filetype=$(file -b --mime-type "$tmp_file" 2>/dev/null)
    printf '\033_Ga=d\033\\'

    case "$filetype" in
        image/*)
            chafa --format=kitty --size="${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}" --animate=off "$tmp_file" 2>/dev/null || echo "[Image: $filetype]"
            ;;
        *)
            if command -v bat &>/dev/null; then
                # Try to detect language from content
                content=$(head -c 1000 "$tmp_file")
                lang=""

                if [[ "$content" =~ ^(\{|\[).*(:|\,) ]] && [[ "$content" =~ (\}|\])$ ]]; then
                    lang="json"
                elif [[ "$content" =~ (function|const|let|var|=\>|import.*from|export|async|await) ]]; then
                    lang="javascript"
                elif [[ "$content" =~ (def |class |import |from.*import|if __name__|print\() ]]; then
                    lang="python"
                elif [[ "$content" =~ (\<\!DOCTYPE|\<html|\<div|\<span|\<p\>|\</[a-z]+\>) ]]; then
                    lang="html"
                elif [[ "$content" =~ (^\#include|\-\>|std::|int main|void |nullptr) ]]; then
                    lang="cpp"
                elif [[ "$content" =~ (func |package |:=|go |fmt\.) ]]; then
                    lang="go"
                elif [[ "$content" =~ (fn |let mut|impl |use |pub |::) ]]; then
                    lang="rust"
                elif [[ "$content" =~ (\#!/.*bash|\#!/.*sh|if \[\[|then|fi|esac) ]]; then
                    lang="bash"
                elif [[ "$content" =~ (\{[^}]*:[^}]*\}|@media|@import|px;|em;|rem;) ]]; then
                    lang="css"
                fi

                if [[ -n "$lang" ]]; then
                    bat --color=always --style=plain --paging=never -l "$lang" "$tmp_file" 2>/dev/null
                else
                    bat --color=always --style=plain --paging=never "$tmp_file" 2>/dev/null
                fi
            else
                cat "$tmp_file" 2>/dev/null
            fi
            ;;
    esac

    rm -f "$tmp_file"
}
export -f preview

# Read colors from rofi theme
COLORS_FILE="$HOME/.config/rofi/colors.rasi"
get_color() {
    grep -oP "$1:\s*\K[^;]+" "$COLORS_FILE" | tr -d ' '
}

foreground=$(get_color "foreground")
foreground_alt=$(get_color "foreground-alt")
color0=$(get_color "color0")
color11=$(get_color "color11")
color5=$(get_color "color5")
color3=$(get_color "color3")
color6=$(get_color "color6")
color7=$(get_color "color7")

export FZF_DEFAULT_OPTS="
    --color=bg:-1,bg+:${color11},fg:${foreground},fg+:${color0}
    --color=hl:${color5},hl+:${color0},info:${color3},marker:${color6}
    --color=prompt:${color11},spinner:${color5},pointer:${color7},header:${foreground_alt}
    --color=border:${color11},label:${foreground},query:${foreground}
"

# Add icons based on content type
add_icons() {
    while IFS= read -r line; do
        # Get content after the tab (cliphist format: "id\tcontent")
        content="${line#*	}"
        if [[ "$content" == *"binary"*"png"* ]] || [[ "$content" == *"binary"*"jpg"* ]] || [[ "$content" == *"binary"*"jpeg"* ]] || [[ "$content" == *"binary"*"bmp"* ]] || [[ "$content" == *"binary"*"gif"* ]] || [[ "$content" == *"binary"*"webp"* ]]; then
            icon="󰋩"
        elif [[ "$content" == http://* ]] || [[ "$content" == https://* ]] || [[ "$content" == www.* ]]; then
            icon="󰌹"
        else
            icon="󰈚"
        fi
        # Output: icon space original_line
        printf '%s %s\n' "$icon" "$line"
    done
}
export -f add_icons

# Main selection with fzf
# Field 1: icon, Field 2: cliphist id, Field 3+: content
selected=$(cliphist list | add_icons | fzf \
    --with-nth=1,3.. \
    --preview 'preview {2..}' \
    --preview-window=right:60%:wrap:border-bold \
    --bind='ctrl-d:execute-silent(echo {2..} | cliphist delete)+reload(cliphist list | add_icons)' \
    --header='Enter: copy | Ctrl-D: delete' \
    --prompt='Clipboard > ' \
    --layout=reverse \
    --height=100% \
    --border=none \
    --padding=1)

# Extract original cliphist line (remove icon prefix) and copy to clipboard
if [[ -n "$selected" ]]; then
    # Remove the icon and space at the beginning
    original_line="${selected#* }"
    echo "$original_line" | cliphist decode | wl-copy
fi
