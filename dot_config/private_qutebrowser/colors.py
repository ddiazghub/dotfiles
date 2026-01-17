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
c.colors.completion.fg = "#d0e4ff"
c.colors.completion.odd.bg = rgba("#001d34", 0.85)
c.colors.completion.even.bg = rgba("#001d34", 0.85)
c.colors.completion.category.fg = "#d0e4ff"
c.colors.completion.category.bg = rgba("#154974", 0.9)
c.colors.completion.category.border.top = rgba("#d0e4ff", 0.9)
c.colors.completion.category.border.bottom = rgba("#d0e4ff", 0.9)
c.colors.completion.item.selected.fg = "#003256"
c.colors.completion.item.selected.bg = rgba("#9ecafc", 0.9)
c.colors.completion.item.selected.border.top = rgba("#9ecafc", 0.9)
c.colors.completion.item.selected.border.bottom = rgba("#9ecafc", 0.9)
c.colors.completion.item.selected.match.fg = "#3a2a48"
c.colors.completion.match.fg = "#d5bee5"
c.colors.completion.scrollbar.fg = "#9ecafc"
c.colors.completion.scrollbar.bg = rgba("#001d34", 0.85)

# Context menu
c.colors.contextmenu.disabled.bg = rgba("#001d34", 0.7)
c.colors.contextmenu.disabled.fg = "#c2c7cf"
c.colors.contextmenu.menu.bg = rgba("#001d34", 0.9)
c.colors.contextmenu.menu.fg = "#d0e4ff"
c.colors.contextmenu.selected.bg = rgba("#154974", 0.9)
c.colors.contextmenu.selected.fg = "#d0e4ff"

# Downloads
c.colors.downloads.bar.bg = rgba("#001d34", 0.85)
c.colors.downloads.start.fg = "#003256"
c.colors.downloads.start.bg = rgba("#9ecafc", 0.9)
c.colors.downloads.stop.fg = "#243140"
c.colors.downloads.stop.bg = rgba("#bac8db", 0.9)
c.colors.downloads.error.fg = "#ffb4ab"

# Hints
c.colors.hints.fg = "#3a2a48"
c.colors.hints.bg = rgba("#d5bee5", 0.9)
c.colors.hints.match.fg = "#f1dbff"

# Keyhint widget
c.colors.keyhint.fg = "#d0e4ff"
c.colors.keyhint.suffix.fg = "#9ecafc"
c.colors.keyhint.bg = rgba("#001d34", 0.85)

# Messages
c.colors.messages.error.fg = "#ffb4ab"
c.colors.messages.error.bg = rgba("#690005", 0.9)
c.colors.messages.error.border = rgba("#ffb4ab", 0.9)
c.colors.messages.warning.fg = "#f1dbff"
c.colors.messages.warning.bg = rgba("#514060", 0.9)
c.colors.messages.warning.border = rgba("#f1dbff", 0.9)
c.colors.messages.info.fg = "#d0e4ff"
c.colors.messages.info.bg = rgba("#001d34", 0.85)
c.colors.messages.info.border = rgba("#d0e4ff", 0.85)

# Prompts
c.colors.prompts.fg = "#d0e4ff"
c.colors.prompts.border = "#9ecafc"
c.colors.prompts.bg = rgba("#001d34", 0.9)
c.colors.prompts.selected.bg = rgba("#154974", 0.9)
c.colors.prompts.selected.fg = "#d0e4ff"

# Statusbar
c.colors.statusbar.normal.fg = "#d0e4ff"
c.colors.statusbar.normal.bg = rgba("#001d34", 0.1)
c.colors.statusbar.insert.fg = "#d0e4ff"
c.colors.statusbar.insert.bg = rgba("#154974", 0.9)
c.colors.statusbar.passthrough.fg = "#243140"
c.colors.statusbar.passthrough.bg = rgba("#bac8db", 0.9)
c.colors.statusbar.private.fg = "#f1dbff"
c.colors.statusbar.private.bg = rgba("#514060", 0.85)
c.colors.statusbar.command.fg = "#d0e4ff"
c.colors.statusbar.command.bg = rgba("#154974", 0.85)
c.colors.statusbar.command.private.fg = "#f1dbff"
c.colors.statusbar.command.private.bg = rgba("#514060", 0.85)
c.colors.statusbar.caret.fg = "#f1dbff"
c.colors.statusbar.caret.bg = rgba("#514060", 0.9)
c.colors.statusbar.caret.selection.fg = "#f1dbff"
c.colors.statusbar.caret.selection.bg = rgba("#514060", 0.9)
c.colors.statusbar.progress.bg = rgba("#9ecafc", 0.9)
c.colors.statusbar.url.fg = "#d0e4ff"
c.colors.statusbar.url.error.fg = "#ffb4ab"
c.colors.statusbar.url.hover.fg = "#9ecafc"
c.colors.statusbar.url.success.http.fg = "#d6e4f7"
c.colors.statusbar.url.success.https.fg = "#f1dbff"
c.colors.statusbar.url.warn.fg = "#93000a"

# Tabs
c.colors.tabs.bar.bg = rgba("#001d34", 0.1)
c.colors.tabs.indicator.start = "#bac8db"
c.colors.tabs.indicator.stop = blend_colors("#9ecafc", "#00ff00", 0.4)
c.colors.tabs.indicator.error = "#ffb4ab"
c.colors.tabs.odd.fg = "#d0e4ff"
c.colors.tabs.odd.bg = rgba("#001d34", 0.4)
c.colors.tabs.even.fg = "#d0e4ff"
c.colors.tabs.even.bg = rgba("#001d34", 0.4)
c.colors.tabs.pinned.even.bg = rgba("#514060", 0.9)
c.colors.tabs.pinned.even.fg = "#f1dbff"
c.colors.tabs.pinned.odd.bg = rgba("#514060", 0.9)
c.colors.tabs.pinned.odd.fg = "#f1dbff"
c.colors.tabs.pinned.selected.even.bg = rgba("#154974", 0.9)
c.colors.tabs.pinned.selected.even.fg = "#d0e4ff"
c.colors.tabs.pinned.selected.odd.bg = rgba("#154974", 0.9)
c.colors.tabs.pinned.selected.odd.fg = "#d0e4ff"
c.colors.tabs.selected.odd.fg = "#003256"
c.colors.tabs.selected.odd.bg = rgba("#9ecafc", 0.7)
c.colors.tabs.selected.even.fg = "#003256"
c.colors.tabs.selected.even.bg = rgba("#9ecafc", 0.7)
