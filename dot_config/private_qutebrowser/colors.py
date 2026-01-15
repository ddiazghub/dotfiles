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
c.colors.completion.fg = "#ffdea8"
c.colors.completion.odd.bg = rgba("#271900", 0.85)
c.colors.completion.even.bg = rgba("#271900", 0.85)
c.colors.completion.category.fg = "#ffdea8"
c.colors.completion.category.bg = rgba("#5e4200", 0.9)
c.colors.completion.category.border.top = rgba("#ffdea8", 0.9)
c.colors.completion.category.border.bottom = rgba("#ffdea8", 0.9)
c.colors.completion.item.selected.fg = "#422d00"
c.colors.completion.item.selected.bg = rgba("#eebf6d", 0.9)
c.colors.completion.item.selected.border.top = rgba("#eebf6d", 0.9)
c.colors.completion.item.selected.border.bottom = rgba("#eebf6d", 0.9)
c.colors.completion.item.selected.match.fg = "#203619"
c.colors.completion.match.fg = "#b3cea6"
c.colors.completion.scrollbar.fg = "#eebf6d"
c.colors.completion.scrollbar.bg = rgba("#271900", 0.85)

# Context menu
c.colors.contextmenu.disabled.bg = rgba("#271900", 0.7)
c.colors.contextmenu.disabled.fg = "#d1c5b4"
c.colors.contextmenu.menu.bg = rgba("#271900", 0.9)
c.colors.contextmenu.menu.fg = "#ffdea8"
c.colors.contextmenu.selected.bg = rgba("#5e4200", 0.9)
c.colors.contextmenu.selected.fg = "#ffdea8"

# Downloads
c.colors.downloads.bar.bg = rgba("#271900", 0.85)
c.colors.downloads.start.fg = "#422d00"
c.colors.downloads.start.bg = rgba("#eebf6d", 0.9)
c.colors.downloads.stop.fg = "#3c2e15"
c.colors.downloads.stop.bg = rgba("#dac3a0", 0.9)
c.colors.downloads.error.fg = "#ffb4ab"

# Hints
c.colors.hints.fg = "#203619"
c.colors.hints.bg = rgba("#b3cea6", 0.9)
c.colors.hints.match.fg = "#cfebc1"

# Keyhint widget
c.colors.keyhint.fg = "#ffdea8"
c.colors.keyhint.suffix.fg = "#eebf6d"
c.colors.keyhint.bg = rgba("#271900", 0.85)

# Messages
c.colors.messages.error.fg = "#ffb4ab"
c.colors.messages.error.bg = rgba("#690005", 0.9)
c.colors.messages.error.border = rgba("#ffb4ab", 0.9)
c.colors.messages.warning.fg = "#cfebc1"
c.colors.messages.warning.bg = rgba("#364d2e", 0.9)
c.colors.messages.warning.border = rgba("#cfebc1", 0.9)
c.colors.messages.info.fg = "#ffdea8"
c.colors.messages.info.bg = rgba("#271900", 0.85)
c.colors.messages.info.border = rgba("#ffdea8", 0.85)

# Prompts
c.colors.prompts.fg = "#ffdea8"
c.colors.prompts.border = "#eebf6d"
c.colors.prompts.bg = rgba("#271900", 0.9)
c.colors.prompts.selected.bg = rgba("#5e4200", 0.9)
c.colors.prompts.selected.fg = "#ffdea8"

# Statusbar
c.colors.statusbar.normal.fg = "#ffdea8"
c.colors.statusbar.normal.bg = rgba("#271900", 0.7)
c.colors.statusbar.insert.fg = "#422d00"
c.colors.statusbar.insert.bg = rgba("#eebf6d", 0.9)
c.colors.statusbar.passthrough.fg = "#3c2e15"
c.colors.statusbar.passthrough.bg = rgba("#dac3a0", 0.9)
c.colors.statusbar.private.fg = "#cfebc1"
c.colors.statusbar.private.bg = rgba("#364d2e", 0.85)
c.colors.statusbar.command.fg = "#ffdea8"
c.colors.statusbar.command.bg = rgba("#5e4200", 0.85)
c.colors.statusbar.command.private.fg = "#cfebc1"
c.colors.statusbar.command.private.bg = rgba("#364d2e", 0.85)
c.colors.statusbar.caret.fg = "#cfebc1"
c.colors.statusbar.caret.bg = rgba("#0b2006", 0.9)
c.colors.statusbar.caret.selection.fg = "#cfebc1"
c.colors.statusbar.caret.selection.bg = rgba("#364d2e", 0.9)
c.colors.statusbar.progress.bg = rgba("#eebf6d", 0.9)
c.colors.statusbar.url.fg = "#ffdea8"
c.colors.statusbar.url.error.fg = "#ffb4ab"
c.colors.statusbar.url.hover.fg = "#eebf6d"
c.colors.statusbar.url.success.http.fg = "#f7dfbb"
c.colors.statusbar.url.success.https.fg = "#cfebc1"
c.colors.statusbar.url.warn.fg = "#93000a"

# Tabs
c.colors.tabs.bar.bg = rgba("#271900", 0.2)
c.colors.tabs.indicator.start = "#dac3a0"
c.colors.tabs.indicator.stop = blend_colors("#eebf6d", "#00ff00", 0.4)
c.colors.tabs.indicator.error = "#ffb4ab"
c.colors.tabs.odd.fg = "#ffdea8"
c.colors.tabs.odd.bg = rgba("#271900", 0.4)
c.colors.tabs.even.fg = "#ffdea8"
c.colors.tabs.even.bg = rgba("#271900", 0.4)
c.colors.tabs.pinned.even.bg = rgba("#364d2e", 0.9)
c.colors.tabs.pinned.even.fg = "#cfebc1"
c.colors.tabs.pinned.odd.bg = rgba("#364d2e", 0.9)
c.colors.tabs.pinned.odd.fg = "#cfebc1"
c.colors.tabs.pinned.selected.even.bg = rgba("#5e4200", 0.9)
c.colors.tabs.pinned.selected.even.fg = "#ffdea8"
c.colors.tabs.pinned.selected.odd.bg = rgba("#5e4200", 0.9)
c.colors.tabs.pinned.selected.odd.fg = "#ffdea8"
c.colors.tabs.selected.odd.fg = "#422d00"
c.colors.tabs.selected.odd.bg = rgba("#eebf6d", 0.7)
c.colors.tabs.selected.even.fg = "#422d00"
c.colors.tabs.selected.even.bg = rgba("#eebf6d", 0.7)
