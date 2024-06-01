import json
import os

from base import base_update

CONFIG_PATH = os.path.expanduser("~/.config/sway/config.d/theme.conf")
CONFIG_TEMPLATE_PATH = "./templates/sway.template"


def update(flavour: str, color: str):
    theme = json.load(open("./themes/catppuccin.json"))[flavour]
    theme["colors"]["main_colorscheme"] = theme["colors"][color]

    base_update(theme["colors"], CONFIG_TEMPLATE_PATH, CONFIG_PATH)
