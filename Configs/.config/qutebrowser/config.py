# pylint: disable=C0111
c = c  # noqa: F821 pylint: disable=E0602,C0103
config = config  # noqa: F821 pylint: disable=E0602,C0103
# pylint settings included to disable linting errors

import subprocess


def read_kitty():
    props = {}
    try:
        k = subprocess.run(
            "kitten @ --to unix:/tmp/mykitty get-colors",
            shell=True,
            capture_output=True,
            text=True,
            check=True,
        )
        lines = k.stdout.split("\n")
        for line in lines:
            prop, _, value = line.partition(" ")
            props[prop.strip()] = value.strip()
    except subprocess.CalledProcessError:
        props.update(
            {
                "background": "#24283b",
                "foreground": "#c0caf5",
                "color0": "#1d202f",
                "color1": "#f7768e",
                "color2": "#9ece6a",
                "color3": "#e0af68",
                "color4": "#7aa2f7",
                "color5": "#bb9af7",
                "color6": "#7dcfff",
                "color7": "#a9b1d6",
                "color8": "#414868",
                "color9": "#f7768e",
                "color10": "#9ece6a",
                "color11": "#e0af68",
                "color12": "#7aa2f7",
                "color13": "#bb9af7",
                "color14": "#7dcfff",
            }
        )
    return props


kitty_colors = read_kitty()

c.colors.statusbar.normal.bg = "#00000000"
c.colors.statusbar.command.bg = "#00000000"
# c.colors.statusbar.normal.bg = kitty_colors["background"]
# c.colors.statusbar.command.bg = kitty_colors["background"]
c.colors.statusbar.command.fg = kitty_colors["foreground"]
c.colors.statusbar.normal.fg = kitty_colors["color14"]
c.colors.statusbar.passthrough.fg = kitty_colors["color14"]
c.colors.statusbar.url.fg = kitty_colors["color13"]
c.colors.statusbar.url.success.https.fg = kitty_colors["color13"]
c.colors.statusbar.url.hover.fg = kitty_colors["color12"]
# c.statusbar.show = "always"
c.colors.tabs.even.bg = "#00000000"  # transparent tabs!!
c.colors.tabs.odd.bg = "#00000000"
c.colors.tabs.bar.bg = "#00000000"
# c.colors.tabs.even.bg = kitty_colors["background"]
# c.colors.tabs.odd.bg = kitty_colors["background"]
c.colors.tabs.even.fg = kitty_colors["color0"]
c.colors.tabs.odd.fg = kitty_colors["color0"]
c.colors.tabs.selected.even.bg = kitty_colors["foreground"]
c.colors.tabs.selected.odd.bg = kitty_colors["foreground"]
c.colors.tabs.selected.even.fg = kitty_colors["background"]
c.colors.tabs.selected.odd.fg = kitty_colors["background"]
c.colors.hints.bg = kitty_colors["background"]
c.colors.hints.fg = kitty_colors["foreground"]
c.tabs.show = "multiple"

c.colors.completion.item.selected.match.fg = kitty_colors["color6"]
c.colors.completion.match.fg = kitty_colors["color6"]

c.colors.tabs.indicator.start = kitty_colors["color10"]
c.colors.tabs.indicator.stop = kitty_colors["color8"]
c.colors.completion.odd.bg = kitty_colors["background"]
c.colors.completion.even.bg = kitty_colors["background"]
c.colors.completion.fg = kitty_colors["foreground"]
c.colors.completion.category.bg = kitty_colors["background"]
c.colors.completion.category.fg = kitty_colors["foreground"]
c.colors.completion.item.selected.bg = kitty_colors["background"]
c.colors.completion.item.selected.fg = kitty_colors["foreground"]

c.colors.messages.info.bg = kitty_colors["background"]
c.colors.messages.info.fg = kitty_colors["foreground"]
c.colors.messages.error.bg = kitty_colors["background"]
c.colors.messages.error.fg = kitty_colors["foreground"]
c.colors.downloads.error.bg = kitty_colors["background"]
c.colors.downloads.error.fg = kitty_colors["foreground"]

c.colors.downloads.bar.bg = kitty_colors["background"]
c.colors.downloads.start.bg = kitty_colors["color10"]
c.colors.downloads.start.fg = kitty_colors["foreground"]
c.colors.downloads.stop.bg = kitty_colors["color8"]
c.colors.downloads.stop.fg = kitty_colors["foreground"]

c.colors.tooltip.bg = kitty_colors["background"]
c.colors.webpage.bg = kitty_colors["background"]
c.hints.border = kitty_colors["foreground"]


# c.colors.statusbar.normal.bg = "#24283b"
# c.colors.statusbar.normal.fg = "#c0caf5"
# c.colors.statusbar.command.bg = "#24283b"
# c.colors.statusbar.command.fg = "#7dcfff"
# c.colors.statusbar.passthrough.fg = "#7dcfff"
# c.colors.statusbar.url.fg = "#bb9af7"
# c.colors.statusbar.url.success.https.fg = "#bb9af7"
# c.colors.statusbar.url.hover.fg = "#7aa2f7"
# # c.statusbar.show = "always"
# c.colors.tabs.even.bg = "#24283b"  # transparent tabs!!
# c.colors.tabs.odd.bg = "#24283b"
# c.colors.tabs.bar.bg = "#24283b"
# c.colors.tabs.even.fg = "#1d202f"
# c.colors.tabs.odd.fg = "#1d202f"
# c.colors.tabs.selected.even.bg = "#c0caf5"
# c.colors.tabs.selected.odd.bg = "#c0caf5"
# c.colors.tabs.selected.even.fg = "#24283b"
# c.colors.tabs.selected.odd.fg = "#24283b"
# c.colors.hints.bg = "#24283b"
# c.colors.hints.fg = "#c0caf5"
# c.tabs.show = "multiple"
#
# c.colors.completion.item.selected.match.fg = "#7dcfff"
# c.colors.completion.match.fg = "#7dcfff"
#
# c.colors.tabs.indicator.start = "#9ece6a"
# c.colors.tabs.indicator.stop = "#414868"
# c.colors.completion.odd.bg = "#24283b"
# c.colors.completion.even.bg = "#24283b"
# c.colors.completion.fg = "#c0caf5"
# c.colors.completion.category.bg = "#24283b"
# c.colors.completion.category.fg = "#c0caf5"
# c.colors.completion.item.selected.bg = "#24283b"
# c.colors.completion.item.selected.fg = "#c0caf5"
#
# c.colors.messages.info.bg = "#24283b"
# c.colors.messages.info.fg = "#c0caf5"
# c.colors.messages.error.bg = "#24283b"
# c.colors.messages.error.fg = "#c0caf5"
# c.colors.downloads.error.bg = "#24283b"
# c.colors.downloads.error.fg = "#c0caf5"
#
# c.colors.downloads.bar.bg = "#24283b"
# c.colors.downloads.start.bg = "#9ece6a"
# c.colors.downloads.start.fg = "#c0caf5"
# c.colors.downloads.stop.bg = "#414868"
# c.colors.downloads.stop.fg = "#c0caf5"
#
# c.colors.tooltip.bg = "#24283b"
# c.colors.webpage.bg = "#24283b"
# c.hints.border = "#c0caf5"

c.tabs.title.format = "{audio}{current_title}"
c.fonts.web.size.default = 20

c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "!aw": "https://wiki.archlinux.org/?search={}",
    "!apkg": "https://archlinux.org/packages/?sort=&q={}&maintainer=&flagged=",
    "!gh": "https://github.com/search?o=desc&q={}&s=stars",
    "!yt": "https://www.youtube.com/results?search_query={}",
}

c.completion.open_categories = [
    "searchengines",
    "quickmarks",
    "bookmarks",
    "history",
    "filesystem",
]

config.load_autoconfig()  # load settings done via the gui

config.bind("gp", "spawn qute-bitwarden")

c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = "lightness-cielab"
c.colors.webpage.darkmode.policy.images = "never"
config.set("colors.webpage.darkmode.enabled", False, "file://*")

# styles, cosmetics
c.tabs.padding = {"top": 5, "bottom": 5, "left": 9, "right": 9}
# c.tabs.indicator.width = 0  # no tab indicators
# c.window.transparent = True # apparently not needed
c.tabs.width = "7%"

# Adblocking info -->
# For yt ads: place the greasemonkey script yt-ads.js in your greasemonkey folder (~/.config/qutebrowser/greasemonkey).
# The script skips through the entire ad, so all you have to do is click the skip button.
# Yeah it's not ublock origin, but if you want a minimal browser, this is a solution for the tradeoff.
# You can also watch yt vids directly in mpv, see qutebrowser FAQ for how to do that.
# If you want additional blocklists, you can get the python-adblock package, or you can uncomment the ublock lists here.
c.content.blocking.enabled = True
# uncomment this if you install python-adblock
c.content.blocking.method = "adblock"
c.content.blocking.adblock.lists = [
    "https://github.com/ewpratten/youtube_ad_blocklist/blob/master/blocklist.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/legacy.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2021.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2022.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2023.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2024.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badware.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-cookies.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-others.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/quick-fixes.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt",
]
