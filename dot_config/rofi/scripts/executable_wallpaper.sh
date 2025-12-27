#!/usr/bin/env bash

# Directories
WALL_DIR="$HOME/Pictures/Wallpapers"
CACHE_DIR="$HOME/.cache/thumbnails/wallpaper_selector"
THUMB_SIZE="250x220"

# Create cache directory if needed
mkdir -p "$CACHE_DIR"

# Generate thumbnails for all images (recursively)
generate_thumbnails() {
	find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" \) | while read -r img; do
		# Create a unique cache filename based on path
		cache_name=$(echo "$img" | md5sum | cut -d' ' -f1).jpg
		cache_path="$CACHE_DIR/$cache_name"

		if [[ ! -f "$cache_path" ]]; then
			if [[ "${img,,}" == *.gif ]]; then
				# For GIFs, extract first frame
				magick "$img[0]" -thumbnail "$THUMB_SIZE^" -gravity center -extent "$THUMB_SIZE" "$cache_path" 2>/dev/null
			else
				magick "$img" -thumbnail "$THUMB_SIZE^" -gravity center -extent "$THUMB_SIZE" "$cache_path" 2>/dev/null
			fi
		fi

		# Output for rofi: "filename\0icon\x1f/path/to/thumbnail"
		filename=$(basename "$img")
		echo -e "${filename}\0icon\x1f${cache_path}\x1fmeta\x1f${img}"
	done
}

# Rofi command
rofi_cmd() {
	rofi -dmenu \
		-p "Wallpaper" \
		-config ~/.config/rofi/wallpaper.rasi
}

# Run
selection=$(generate_thumbnails | rofi_cmd)

if [[ -n "$selection" ]]; then
	# Find the full path by matching filename
	filename="$selection"
	wallpaper=$(find "$WALL_DIR" -type f -name "$filename" | head -1)

	if [[ -n "$wallpaper" ]]; then
		if [[ "${wallpaper,,}" == *.gif ]]; then
			# For GIFs, notify user it may take time
			notify-send "Wallpaper" "Loading GIF: $filename (this may take a moment...)"
		fi

		matugen image "$wallpaper" && notify-send "Wallpaper" "Changed to $filename"
	fi
fi
