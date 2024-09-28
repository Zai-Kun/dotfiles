import os
from types import ModuleType

from _base import base_update, run_shell_command

CONFIG_PATH = os.path.expanduser("~/.config/sway/config.d/theme.conf")
CONFIG_TEMPLATE_PATH = "./templates/sway_template.conf"


def update(theme: ModuleType, accent: str | None, _):
    if accent:
        theme.COLORS["main_colorscheme"] = theme.COLORS[accent]
    base_update(theme.COLORS, CONFIG_TEMPLATE_PATH, CONFIG_PATH)
    run_shell_command("swaymsg reload")
