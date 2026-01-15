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
c.colors.completion.fg = "#e8e78f"
c.colors.completion.odd.bg = rgba("#1d1d00", 0.85)
c.colors.completion.even.bg = rgba("#1d1d00", 0.85)
c.colors.completion.category.fg = "#e8e78f"
c.colors.completion.category.bg = rgba("#494900", 0.9)
c.colors.completion.category.border.top = rgba("#e8e78f", 0.9)
c.colors.completion.category.border.bottom = rgba("#e8e78f", 0.9)
c.colors.completion.item.selected.fg = "#323200"
c.colors.completion.item.selected.bg = rgba("#cbcb76", 0.9)
c.colors.completion.item.selected.border.top = rgba("#cbcb76", 0.9)
c.colors.completion.item.selected.border.bottom = rgba("#cbcb76", 0.9)
c.colors.completion.item.selected.match.fg = "#0b372a"
c.colors.completion.match.fg = "#a4d0bd"
c.colors.completion.scrollbar.fg = "#cbcb76"
c.colors.completion.scrollbar.bg = rgba("#1d1d00", 0.85)

# Context menu
c.colors.contextmenu.disabled.bg = rgba("#1d1d00", 0.7)
c.colors.contextmenu.disabled.fg = "#cac7b6"
c.colors.contextmenu.menu.bg = rgba("#1d1d00", 0.9)
c.colors.contextmenu.menu.fg = "#e8e78f"
c.colors.contextmenu.selected.bg = rgba("#494900", 0.9)
c.colors.contextmenu.selected.fg = "#e8e78f"

# Downloads
c.colors.downloads.bar.bg = rgba("#1d1d00", 0.85)
c.colors.downloads.start.fg = "#323200"
c.colors.downloads.start.bg = rgba("#cbcb76", 0.9)
c.colors.downloads.stop.fg = "#323218"
c.colors.downloads.stop.bg = rgba("#cac8a5", 0.9)
c.colors.downloads.error.fg = "#ffb4ab"

# Hints
c.colors.hints.fg = "#0b372a"
c.colors.hints.bg = rgba("#a4d0bd", 0.9)
c.colors.hints.match.fg = "#bfecd8"

# Keyhint widget
c.colors.keyhint.fg = "#e8e78f"
c.colors.keyhint.suffix.fg = "#cbcb76"
c.colors.keyhint.bg = rgba("#1d1d00", 0.85)

# Messages
c.colors.messages.error.fg = "#ffb4ab"
c.colors.messages.error.bg = rgba("#690005", 0.9)
c.colors.messages.error.border = rgba("#ffb4ab", 0.9)
c.colors.messages.warning.fg = "#bfecd8"
c.colors.messages.warning.bg = rgba("#254e40", 0.9)
c.colors.messages.warning.border = rgba("#bfecd8", 0.9)
c.colors.messages.info.fg = "#e8e78f"
c.colors.messages.info.bg = rgba("#1d1d00", 0.85)
c.colors.messages.info.border = rgba("#e8e78f", 0.85)

# Prompts
c.colors.prompts.fg = "#e8e78f"
c.colors.prompts.border = "#cbcb76"
c.colors.prompts.bg = rgba("#1d1d00", 0.9)
c.colors.prompts.selected.bg = rgba("#494900", 0.9)
c.colors.prompts.selected.fg = "#e8e78f"

# Statusbar
c.colors.statusbar.normal.fg = "#e8e78f"
c.colors.statusbar.normal.bg = rgba("#1d1d00", 0.7)
c.colors.statusbar.insert.fg = "#323200"
c.colors.statusbar.insert.bg = rgba("#cbcb76", 0.9)
c.colors.statusbar.passthrough.fg = "#323218"
c.colors.statusbar.passthrough.bg = rgba("#cac8a5", 0.9)
c.colors.statusbar.private.fg = "#bfecd8"
c.colors.statusbar.private.bg = rgba("#254e40", 0.85)
c.colors.statusbar.command.fg = "#e8e78f"
c.colors.statusbar.command.bg = rgba("#494900", 0.85)
c.colors.statusbar.command.private.fg = "#bfecd8"
c.colors.statusbar.command.private.bg = rgba("#254e40", 0.85)
c.colors.statusbar.caret.fg = "#bfecd8"
c.colors.statusbar.caret.bg = rgba("#002117", 0.9)
c.colors.statusbar.caret.selection.fg = "#bfecd8"
c.colors.statusbar.caret.selection.bg = rgba("#254e40", 0.9)
c.colors.statusbar.progress.bg = rgba("#cbcb76", 0.9)
c.colors.statusbar.url.fg = "#e8e78f"
c.colors.statusbar.url.error.fg = "#ffb4ab"
c.colors.statusbar.url.hover.fg = "#cbcb76"
c.colors.statusbar.url.success.http.fg = "#e7e4bf"
c.colors.statusbar.url.success.https.fg = "#bfecd8"
c.colors.statusbar.url.warn.fg = "#93000a"

# Tabs
c.colors.tabs.bar.bg = rgba("#1d1d00", 0.2)
c.colors.tabs.indicator.start = "#cac8a5"
c.colors.tabs.indicator.stop = blend_colors("#cbcb76", "#00ff00", 0.4)
c.colors.tabs.indicator.error = "#ffb4ab"
c.colors.tabs.odd.fg = "#e8e78f"
c.colors.tabs.odd.bg = rgba("#1d1d00", 0.4)
c.colors.tabs.even.fg = "#e8e78f"
c.colors.tabs.even.bg = rgba("#1d1d00", 0.4)
c.colors.tabs.pinned.even.bg = rgba("#254e40", 0.9)
c.colors.tabs.pinned.even.fg = "#bfecd8"
c.colors.tabs.pinned.odd.bg = rgba("#254e40", 0.9)
c.colors.tabs.pinned.odd.fg = "#bfecd8"
c.colors.tabs.pinned.selected.even.bg = rgba("#494900", 0.9)
c.colors.tabs.pinned.selected.even.fg = "#e8e78f"
c.colors.tabs.pinned.selected.odd.bg = rgba("#494900", 0.9)
c.colors.tabs.pinned.selected.odd.fg = "#e8e78f"
c.colors.tabs.selected.odd.fg = "#323200"
c.colors.tabs.selected.odd.bg = rgba("#cbcb76", 0.7)
c.colors.tabs.selected.even.fg = "#323200"
c.colors.tabs.selected.even.bg = rgba("#cbcb76", 0.7)
