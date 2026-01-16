from typing import TYPE_CHECKING
from pathlib import Path

if TYPE_CHECKING:
    from qutebrowser.config.configfiles import ConfigAPI
    from qutebrowser.config.config import ConfigContainer

config: ConfigAPI = globals()["config"]
c: ConfigContainer = globals()["c"]

c.content.user_stylesheets = [str(Path.home() / ".config/qutebrowser/userstyles/matugen-all-sites.css")]

# Webpage darkmode settings
c.colors.webpage.darkmode.algorithm = "lightness-cielab"
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.policy.images = "never"
c.colors.webpage.darkmode.policy.page = "smart"
c.colors.webpage.preferred_color_scheme = "dark"
