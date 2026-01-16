from typing import TYPE_CHECKING
from pathlib import Path

if TYPE_CHECKING:
    from qutebrowser.config.configfiles import ConfigAPI
    from qutebrowser.config.config import ConfigContainer

# This is to shut up type checkers and get type completion
config: ConfigAPI = globals()["config"]
c: ConfigContainer = globals()["c"]

home = Path.home()
config.load_autoconfig(True)

config.source(home / '.config/qutebrowser/bangs.py')
config.source(home / '.config/qutebrowser/binds.py')
config.source(home / '.config/qutebrowser/colors.py')
config.source(home / '.config/qutebrowser/theme.py')
config.source(home / '.config/qutebrowser/options.py')
