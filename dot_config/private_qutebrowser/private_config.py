config.load_autoconfig(True)

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
c.tabs.select_on_remove = "prev"
c.tabs.show = "multiple"
c.tabs.width = "13%"

c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "am": "https://www.amazon.com/s?k={}",
    "aw": "https://wiki.archlinux.org/?search={}",
    "goog": "https://www.google.com/search?q={}",
    "hoog": "https://hoogle.haskell.org/?hoogle={}",
    "re": "https://www.reddit.com/r/{}",
    "ub": "https://www.urbandictionary.com/define.php?term={}",
    "wiki": "https://en.wikipedia.org/wiki/{}",
    "yt": "https://www.youtube.com/results?search_query={}",
}

c.window.hide_decoration = True
c.window.transparent = False

# Enable high-performance GPU features
c.qt.args = [
    "ignore-gpu-blocklist",  # Overrides driver blacklists
    "enable-gpu-rasterization",  # Offloads drawing to GPU
    "enable-zero-copy",  # Faster image/video rendering
]
