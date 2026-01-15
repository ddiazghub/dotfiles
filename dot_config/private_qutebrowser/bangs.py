import json
from pathlib import Path
from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from qutebrowser.config.configfiles import ConfigAPI
    from qutebrowser.config.config import ConfigContainer

# This is to shut up type checkers and get type completion
config: ConfigAPI = globals()["config"]
c: ConfigContainer = globals()["c"]

c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
}

# Load DuckDuckGo bans as search engines.
# WARNING: This loads all bangs into c.url.searchengines on qutebrowser startup. DuckDuckGo has ~13,000+ bangs, which might slow startup slightly.
def load_bangs() -> None:
    bangs_file = Path.home() / ".local/share/qutebrowser/bangs.json"

    if bangs_file.exists():
      with open(bangs_file) as f:
          bangs = json.load(f)

      for trigger, data in bangs.items():
          c.url.searchengines[trigger] = data["url"]

load_bangs()
