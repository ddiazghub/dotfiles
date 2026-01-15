from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from qutebrowser.config.configfiles import ConfigAPI
    from qutebrowser.config.config import ConfigContainer

# This is to shut up type checkers and get type completion
config: ConfigAPI = globals()["config"]
c: ConfigContainer = globals()["c"]

config.bind(";d", "hint links download")
config.bind(";D", "hint images download")
config.bind(";yy", "hint links yank")

# TODO: Create userscript to yank and copy images
config.bind(";yi", "hint images yank")

config.unbind(";y")
config.unbind(";d")
