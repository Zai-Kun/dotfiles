import os
from types import ModuleType

from _base import base_update

CONFIG_PATH = os.path.expanduser("~/.config/waybar/style.css")
CONFIG_TEMPLATE_PATH = "./templates/waybar_template.css"


def update(theme: ModuleType, accent: str | None, _):
    if accent:
        theme.COLORS["main_colorscheme"] = theme.COLORS[accent]
    base_update(theme.COLORS, CONFIG_TEMPLATE_PATH, CONFIG_PATH)
