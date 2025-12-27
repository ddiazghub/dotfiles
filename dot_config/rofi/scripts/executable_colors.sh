#!/usr/bin/env bash

# Matugen Colors Picker for rofi
# Displays the current matugen color scheme and copies the template definition to clipboard

COLORS_FILE="$HOME/.config/rofi/colors.rasi"

# Matugen color definitions (name -> template)
declare -A color_templates=(
    ["primary"]="{{colors.primary.default.hex}}"
    ["primary-fixed"]="{{colors.primary_fixed.default.hex}}"
    ["primary-fixed-dim"]="{{colors.primary_fixed_dim.default.hex}}"
    ["on-primary"]="{{colors.on_primary.default.hex}}"
    ["on-primary-fixed"]="{{colors.on_primary_fixed.default.hex}}"
    ["on-primary-fixed-variant"]="{{colors.on_primary_fixed_variant.default.hex}}"
    ["primary-container"]="{{colors.primary_container.default.hex}}"
    ["on-primary-container"]="{{colors.on_primary_container.default.hex}}"
    ["secondary"]="{{colors.secondary.default.hex}}"
    ["secondary-fixed"]="{{colors.secondary_fixed.default.hex}}"
    ["secondary-fixed-dim"]="{{colors.secondary_fixed_dim.default.hex}}"
    ["on-secondary"]="{{colors.on_secondary.default.hex}}"
    ["on-secondary-fixed"]="{{colors.on_secondary_fixed.default.hex}}"
    ["on-secondary-fixed-variant"]="{{colors.on_secondary_fixed_variant.default.hex}}"
    ["secondary-container"]="{{colors.secondary_container.default.hex}}"
    ["on-secondary-container"]="{{colors.on_secondary_container.default.hex}}"
    ["tertiary"]="{{colors.tertiary.default.hex}}"
    ["tertiary-fixed"]="{{colors.tertiary_fixed.default.hex}}"
    ["tertiary-fixed-dim"]="{{colors.tertiary_fixed_dim.default.hex}}"
    ["on-tertiary"]="{{colors.on_tertiary.default.hex}}"
    ["on-tertiary-fixed"]="{{colors.on_tertiary_fixed.default.hex}}"
    ["on-tertiary-fixed-variant"]="{{colors.on_tertiary_fixed_variant.default.hex}}"
    ["tertiary-container"]="{{colors.tertiary_container.default.hex}}"
    ["on-tertiary-container"]="{{colors.on_tertiary_container.default.hex}}"
    ["error"]="{{colors.error.default.hex}}"
    ["on-error"]="{{colors.on_error.default.hex}}"
    ["error-container"]="{{colors.error_container.default.hex}}"
    ["on-error-container"]="{{colors.on_error_container.default.hex}}"
    ["surface"]="{{colors.surface.default.hex}}"
    ["on-surface"]="{{colors.on_surface.default.hex}}"
    ["on-surface-variant"]="{{colors.on_surface_variant.default.hex}}"
    ["outline"]="{{colors.outline.default.hex}}"
    ["outline-variant"]="{{colors.outline_variant.default.hex}}"
    ["shadow"]="{{colors.shadow.default.hex}}"
    ["scrim"]="{{colors.scrim.default.hex}}"
    ["inverse-surface"]="{{colors.inverse_surface.default.hex}}"
    ["inverse-on-surface"]="{{colors.inverse_on_surface.default.hex}}"
    ["inverse-primary"]="{{colors.inverse_primary.default.hex}}"
    ["surface-dim"]="{{colors.surface_dim.default.hex}}"
    ["surface-bright"]="{{colors.surface_bright.default.hex}}"
    ["surface-container-lowest"]="{{colors.surface_container_lowest.default.hex}}"
    ["surface-container-low"]="{{colors.surface_container_low.default.hex}}"
    ["surface-container"]="{{colors.surface_container.default.hex}}"
    ["surface-container-high"]="{{colors.surface_container_high.default.hex}}"
    ["surface-container-highest"]="{{colors.surface_container_highest.default.hex}}"
    ["background"]="{{colors.background.default.hex}}"
    ["on-background"]="{{colors.on_background.default.hex}}"
)

# Order of colors for display (grouped by category)
color_order=(
    # Primary colors
    "primary"
    "on-primary"
    "primary-container"
    "on-primary-container"
    "primary-fixed"
    "primary-fixed-dim"
    "on-primary-fixed"
    "on-primary-fixed-variant"
    # Secondary colors
    "secondary"
    "on-secondary"
    "secondary-container"
    "on-secondary-container"
    "secondary-fixed"
    "secondary-fixed-dim"
    "on-secondary-fixed"
    "on-secondary-fixed-variant"
    # Tertiary colors
    "tertiary"
    "on-tertiary"
    "tertiary-container"
    "on-tertiary-container"
    "tertiary-fixed"
    "tertiary-fixed-dim"
    "on-tertiary-fixed"
    "on-tertiary-fixed-variant"
    # Error colors
    "error"
    "on-error"
    "error-container"
    "on-error-container"
    # Surface colors
    "surface"
    "on-surface"
    "on-surface-variant"
    "surface-dim"
    "surface-bright"
    "surface-container-lowest"
    "surface-container-low"
    "surface-container"
    "surface-container-high"
    "surface-container-highest"
    # Background
    "background"
    "on-background"
    # Other
    "outline"
    "outline-variant"
    "shadow"
    "scrim"
    "inverse-surface"
    "inverse-on-surface"
    "inverse-primary"
)

# Get hex color value from colors.rasi (handles rgba format too)
get_color_value() {
    local name="$1"
    local value
    value=$(grep -oP "${name}:\s*\K[^;]+" "$COLORS_FILE" | tr -d ' ' | head -1)

    # If it's rgba format, extract the hex-like portion or convert
    if [[ "$value" == rgba* ]]; then
        # Extract RGB values and convert to hex
        local rgb
        rgb=$(echo "$value" | grep -oP 'rgba\(\K[^)]+' | cut -d',' -f1-3)
        local r g b
        r=$(echo "$rgb" | cut -d',' -f1 | tr -d ' ')
        g=$(echo "$rgb" | cut -d',' -f2 | tr -d ' ')
        b=$(echo "$rgb" | cut -d',' -f3 | tr -d ' ')
        printf "#%02x%02x%02x" "$r" "$g" "$b"
    else
        echo "$value"
    fi
}

# Generate a colored circle using Unicode block character
color_circle() {
    local hex="$1"
    # Using a filled circle Unicode character with pango color
    echo "<span foreground='${hex}'>███████</span>"
}

if [[ "$ROFI_RETV" -eq 0 ]]; then
    # Initial call - return list of colors
    echo -en "\0no-custom\x1ftrue\n"
    echo -en "\0markup-rows\x1ftrue\n"

    for name in "${color_order[@]}"; do
        hex=$(get_color_value "$name")
        if [[ -n "$hex" ]]; then
            # Format: ● color-name  #hexvalue
            # Circle colored with the actual color, name for filtering, hex value shown
            circle=$(color_circle "$hex")
            echo -en "${circle}  ${name}  <span alpha='60%' size='small'>${hex}</span>\0info\x1f${name}\n"
        fi
    done

elif [[ "$ROFI_RETV" -eq 1 ]]; then
    # User selected an entry
    # $ROFI_INFO contains the color name we passed
    color_name="$ROFI_INFO"

    if [[ -n "$color_name" && -n "${color_templates[$color_name]}" ]]; then
        template="${color_templates[$color_name]}"
        echo -n "$template" | wl-copy
        notify-send "Matugen Color" "Copied: $template" -t 2000
    fi
fi
