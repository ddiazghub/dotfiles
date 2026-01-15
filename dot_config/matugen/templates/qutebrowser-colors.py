# Matugen-generated qutebrowser colors
# This file is auto-generated - do not edit manually

from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from qutebrowser.config.configfiles import ConfigAPI
    from qutebrowser.config.config import ConfigContainer

config: ConfigAPI = globals()["config"]
c: ConfigContainer = globals()["c"]


def blend_colors(hex1: str, hex2: str, ratio: float = 0.5) -> str:
    """Blend two hex colors. ratio=0 returns hex1, ratio=1 returns hex2."""
    hex1 = hex1.lstrip("#")
    hex2 = hex2.lstrip("#")
    r = int(int(hex1[0:2], 16) * (1 - ratio) + int(hex2[0:2], 16) * ratio)
    g = int(int(hex1[2:4], 16) * (1 - ratio) + int(hex2[2:4], 16) * ratio)
    b = int(int(hex1[4:6], 16) * (1 - ratio) + int(hex2[4:6], 16) * ratio)
    return f"#{r:02x}{g:02x}{b:02x}"


def rgba(hex_color: str, alpha: float = 1.0) -> str:
    """Convert hex color to rgba string."""
    hex_color = hex_color.lstrip("#")
    r = int(hex_color[0:2], 16)
    g = int(hex_color[2:4], 16)
    b = int(hex_color[4:6], 16)
    return f"rgba({r}, {g}, {b}, {alpha})"

# Enable transparent window
c.window.transparent = True

# Completion widget
c.colors.completion.fg = "{{colors.primary_fixed.default.hex}}"
c.colors.completion.odd.bg = rgba("{{colors.on_primary_fixed.default.hex}}", 0.85)
c.colors.completion.even.bg = rgba("{{colors.on_primary_fixed.default.hex}}", 0.85)
c.colors.completion.category.fg = "{{colors.on_primary_container.default.hex}}"
c.colors.completion.category.bg = rgba("{{colors.primary_container.default.hex}}", 0.9)
c.colors.completion.category.border.top = rgba("{{colors.primary_fixed.default.hex}}", 0.9)
c.colors.completion.category.border.bottom = rgba("{{colors.primary_fixed.default.hex}}", 0.9)
c.colors.completion.item.selected.fg = "{{colors.on_primary.default.hex}}"
c.colors.completion.item.selected.bg = rgba("{{colors.primary.default.hex}}", 0.9)
c.colors.completion.item.selected.border.top = rgba("{{colors.primary.default.hex}}", 0.9)
c.colors.completion.item.selected.border.bottom = rgba("{{colors.primary.default.hex}}", 0.9)
c.colors.completion.item.selected.match.fg = "{{colors.on_tertiary.default.hex}}"
c.colors.completion.match.fg = "{{colors.tertiary.default.hex}}"
c.colors.completion.scrollbar.fg = "{{colors.primary.default.hex}}"
c.colors.completion.scrollbar.bg = rgba("{{colors.on_primary_fixed.default.hex}}", 0.85)

# Context menu
c.colors.contextmenu.disabled.bg = rgba("{{colors.on_primary_fixed.default.hex}}", 0.7)
c.colors.contextmenu.disabled.fg = "{{colors.on_surface_variant.default.hex}}"
c.colors.contextmenu.menu.bg = rgba("{{colors.on_primary_fixed.default.hex}}", 0.9)
c.colors.contextmenu.menu.fg = "{{colors.primary_fixed.default.hex}}"
c.colors.contextmenu.selected.bg = rgba("{{colors.primary_container.default.hex}}", 0.9)
c.colors.contextmenu.selected.fg = "{{colors.on_primary_container.default.hex}}"

# Downloads
c.colors.downloads.bar.bg = rgba("{{colors.on_primary_fixed.default.hex}}", 0.85)
c.colors.downloads.start.fg = "{{colors.on_primary.default.hex}}"
c.colors.downloads.start.bg = rgba("{{colors.primary.default.hex}}", 0.9)
c.colors.downloads.stop.fg = "{{colors.on_secondary.default.hex}}"
c.colors.downloads.stop.bg = rgba("{{colors.secondary.default.hex}}", 0.9)
c.colors.downloads.error.fg = "{{colors.error.default.hex}}"

# Hints
c.colors.hints.fg = "{{colors.on_tertiary.default.hex}}"
c.colors.hints.bg = rgba("{{colors.tertiary.default.hex}}", 0.9)
c.colors.hints.match.fg = "{{colors.on_tertiary_container.default.hex}}"

# Keyhint widget
c.colors.keyhint.fg = "{{colors.primary_fixed.default.hex}}"
c.colors.keyhint.suffix.fg = "{{colors.primary.default.hex}}"
c.colors.keyhint.bg = rgba("{{colors.on_primary_fixed.default.hex}}", 0.85)

# Messages
c.colors.messages.error.fg = "{{colors.error.default.hex}}"
c.colors.messages.error.bg = rgba("{{colors.on_error.default.hex}}", 0.9)
c.colors.messages.error.border = rgba("{{colors.error.default.hex}}", 0.9)
c.colors.messages.warning.fg = "{{colors.on_tertiary_container.default.hex}}"
c.colors.messages.warning.bg = rgba("{{colors.tertiary_container.default.hex}}", 0.9)
c.colors.messages.warning.border = rgba("{{colors.on_tertiary_container.default.hex}}", 0.9)
c.colors.messages.info.fg = "{{colors.primary_fixed.default.hex}}"
c.colors.messages.info.bg = rgba("{{colors.on_primary_fixed.default.hex}}", 0.85)
c.colors.messages.info.border = rgba("{{colors.primary_fixed.default.hex}}", 0.85)

# Prompts
c.colors.prompts.fg = "{{colors.primary_fixed.default.hex}}"
c.colors.prompts.border = "{{colors.primary.default.hex}}"
c.colors.prompts.bg = rgba("{{colors.on_primary_fixed.default.hex}}", 0.9)
c.colors.prompts.selected.bg = rgba("{{colors.primary_container.default.hex}}", 0.9)
c.colors.prompts.selected.fg = "{{colors.on_primary_container.default.hex}}"

# Statusbar
c.colors.statusbar.normal.fg = "{{colors.primary_fixed.default.hex}}"
c.colors.statusbar.normal.bg = rgba("{{colors.on_primary_fixed.default.hex}}", 0.7)
c.colors.statusbar.insert.fg = "{{colors.on_primary.default.hex}}"
c.colors.statusbar.insert.bg = rgba("{{colors.primary.default.hex}}", 0.9)
c.colors.statusbar.passthrough.fg = "{{colors.on_secondary.default.hex}}"
c.colors.statusbar.passthrough.bg = rgba("{{colors.secondary.default.hex}}", 0.9)
c.colors.statusbar.private.fg = "{{colors.on_tertiary_container.default.hex}}"
c.colors.statusbar.private.bg = rgba("{{colors.tertiary_container.default.hex}}", 0.85)
c.colors.statusbar.command.fg = "{{colors.on_primary_container.default.hex}}"
c.colors.statusbar.command.bg = rgba("{{colors.primary_container.default.hex}}", 0.85)
c.colors.statusbar.command.private.fg = "{{colors.on_tertiary_container.default.hex}}"
c.colors.statusbar.command.private.bg = rgba("{{colors.tertiary_container.default.hex}}", 0.85)
c.colors.statusbar.caret.fg = "{{colors.tertiary_fixed.default.hex}}"
c.colors.statusbar.caret.bg = rgba("{{colors.on_tertiary_fixed.default.hex}}", 0.9)
c.colors.statusbar.caret.selection.fg = "{{colors.on_tertiary_container.default.hex}}"
c.colors.statusbar.caret.selection.bg = rgba("{{colors.tertiary_container.default.hex}}", 0.9)
c.colors.statusbar.progress.bg = rgba("{{colors.primary.default.hex}}", 0.9)
c.colors.statusbar.url.fg = "{{colors.primary_fixed.default.hex}}"
c.colors.statusbar.url.error.fg = "{{colors.error.default.hex}}"
c.colors.statusbar.url.hover.fg = "{{colors.primary_fixed_dim.default.hex}}"
c.colors.statusbar.url.success.http.fg = "{{colors.secondary_fixed.default.hex}}"
c.colors.statusbar.url.success.https.fg = "{{colors.tertiary_fixed.default.hex}}"
c.colors.statusbar.url.warn.fg = "{{colors.error_container.default.hex}}"

# Tabs
c.colors.tabs.bar.bg = rgba("{{colors.on_primary_fixed.default.hex}}", 0.2)
c.colors.tabs.indicator.start = "{{colors.secondary.default.hex}}"
c.colors.tabs.indicator.stop = blend_colors("{{colors.primary.default.hex}}", "#00ff00", 0.4)
c.colors.tabs.indicator.error = "{{colors.error.default.hex}}"
c.colors.tabs.odd.fg = "{{colors.primary_fixed.default.hex}}"
c.colors.tabs.odd.bg = rgba("{{colors.on_primary_fixed.default.hex}}", 0.4)
c.colors.tabs.even.fg = "{{colors.primary_fixed.default.hex}}"
c.colors.tabs.even.bg = rgba("{{colors.on_primary_fixed.default.hex}}", 0.4)
c.colors.tabs.pinned.even.bg = rgba("{{colors.tertiary_container.default.hex}}", 0.9)
c.colors.tabs.pinned.even.fg = "{{colors.on_tertiary_container.default.hex}}"
c.colors.tabs.pinned.odd.bg = rgba("{{colors.tertiary_container.default.hex}}", 0.9)
c.colors.tabs.pinned.odd.fg = "{{colors.on_tertiary_container.default.hex}}"
c.colors.tabs.pinned.selected.even.bg = rgba("{{colors.primary_container.default.hex}}", 0.9)
c.colors.tabs.pinned.selected.even.fg = "{{colors.on_primary_container.default.hex}}"
c.colors.tabs.pinned.selected.odd.bg = rgba("{{colors.primary_container.default.hex}}", 0.9)
c.colors.tabs.pinned.selected.odd.fg = "{{colors.on_primary_container.default.hex}}"
c.colors.tabs.selected.odd.fg = "{{colors.on_primary.default.hex}}"
c.colors.tabs.selected.odd.bg = rgba("{{colors.primary.default.hex}}", 0.7)
c.colors.tabs.selected.even.fg = "{{colors.on_primary.default.hex}}"
c.colors.tabs.selected.even.bg = rgba("{{colors.primary.default.hex}}", 0.7)
