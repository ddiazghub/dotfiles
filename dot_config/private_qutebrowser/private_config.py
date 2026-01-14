import json
from pathlib import Path


config.load_autoconfig(True)

config.bind(";d", "hint links download")
config.bind(";D", "hint images download")
config.bind(";yy", "hint links yank")

# TODO: Create userscript to yank and copy images
config.bind(";yi", "hint images yank")

config.unbind(";y")
config.unbind(";d")

c.auto_save.session = True

c.content.blocking.method = "both"

c.content.javascript.can_open_tabs_automatically = False
c.content.javascript.modal_dialog = True
c.content.javascript.prompt = True

c.colors.tabs.bar.bg = "#44444488"
c.colors.tabs.even.bg = "#44444488"
c.colors.tabs.odd.bg = "#77777788"
# c.colors.webpage.bg = "#77777788"

c.colors.webpage.darkmode.algorithm = "lightness-cielab"
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.policy.images = "never"
c.colors.webpage.darkmode.policy.page = "smart"
c.colors.webpage.preferred_color_scheme = "dark"
c.completion.use_best_match = True

c.confirm_quit = ["downloads", "multiple-tabs"]

with config.pattern("https://accounts.google.com/*") as p:
    p.content.headers.user_agent = (
        "Mozilla/5.0 (X11; Linux x86_64; rv:135.0) Gecko/20100101 Firefox/135.0"
    )

c.content.pdfjs = True
c.content.plugins = True

c.downloads.location.directory = "~/Downloads"
c.content.prefers_reduced_motion = True
c.content.private_browsing = False

c.downloads.location.suggestion = "path"
c.downloads.remove_finished = 10000

c.editor.command = ["ghostty", "-e", "nvim", "{file}", "-c", "normal {line}G{column0}l"]

# External file picker using yazi
c.fileselect.single_file.command = ["ghostty", "-e", "yazi", "--chooser-file={}"]
c.fileselect.multiple_files.command = ["ghostty", "-e", "yazi", "--chooser-file={}"]
c.fileselect.folder.command = ["ghostty", "-e", "yazi", "--cwd-file={}"]

c.fonts.default_family = "JetBrainsMono NF"
c.fonts.default_size = "11pt"

c.input.insert_mode.auto_load = False
c.input.spatial_navigation = False

c.keyhint.delay = 100

c.prompt.filebrowser = True
# c.qt.force_platformtheme
# c.qt.force_software_rendering

c.scrolling.bar = "always"
c.scrolling.smooth = False

c.session.lazy_restore = True

# TODO: Fill
c.spellcheck.languages = []

c.tabs.last_close = "close"
c.tabs.new_position.related = "next"
c.tabs.new_position.unrelated = "next"
c.tabs.position = "left"
c.tabs.select_on_remove = "next"
c.tabs.show = "multiple"
c.tabs.width = "13%"

c.window.hide_decoration = True
c.window.transparent = False

# Enable high-performance GPU features
c.qt.args = [
    "ignore-gpu-blocklist",  # Overrides driver blacklists
    "enable-gpu-rasterization",  # Offloads drawing to GPU
    "enable-zero-copy",  # Faster image/video rendering
]

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
