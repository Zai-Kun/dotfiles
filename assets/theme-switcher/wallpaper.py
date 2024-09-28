import os
import random
from types import ModuleType
from typing import Any

from _base import run_shell_command
from _shared import logger

CONFIG_PATH = os.path.expanduser("~/.config/sway/config.d/wallpaper.conf")
CONFIG_TEMPLATE_PATH = "./templates/wallpaper_template.conf"

WALLPAPERS_PATH = os.path.expanduser("~/dotfiles/assets/wallpapers")
SWWW_PATH = os.path.expanduser("~/dotfiles/assets/sys_bins/swww")


def parse_wallpaper_name(name: str) -> dict[str, Any]:
    parsed_wall = {
        theme.split(".")[0]: (
            split_part[1::] if len((split_part := theme.split("."))) > 1 else []
        )
        for theme in name.split("_,")[0].split("+")
    }

    return parsed_wall


def get_random_wallpaper(
    theme: ModuleType, accent: str | None, path: str
) -> str | None:
    walls = []
    for wall in os.listdir(path):
        parsed_wall = parse_wallpaper_name(wall)
        if not (theme_accents := parsed_wall.get(theme.NAME)):
            continue
        elif accent:
            if len(theme_accents) < 1:
                logger.warning(
                    f"No {theme.NAME}'s accent was found in wallpaper {wall}... Please add an accent to it or remove {theme.NAME} theme from it."
                )
                continue
            if accent not in theme_accents:
                continue
        walls.append(wall)
    if not walls:
        return
    return random.choice(walls)


def update(theme: ModuleType, accent: str, extra_options: dict[str, Any]):
    wall_type = "live"
    wall_name = None

    if extra_options:
        _wall_type = extra_options.get("wallpaper_type")
        if _wall_type and _wall_type in ["static", "live"]:
            wall_type = _wall_type
        else:
            logger.warning("Wallpaper type not defined or invalid... 'live' selected")
        _wall_name = extra_options.get("wall_name")
        wallpapers = os.listdir(os.path.join(WALLPAPERS_PATH, wall_type))

        if _wall_name and _wall_name in wallpapers:
            wall_name = _wall_name
        else:
            logger.warning(
                "Wallpaper name not defined or not found... Selecting at random"
            )

    wallpapers_path = os.path.join(WALLPAPERS_PATH, wall_type)
    wall_name = (
        wall_name if wall_name else get_random_wallpaper(theme, accent, wallpapers_path)
    )
    if not wall_name:
        logger.error(
            f"No wallpaper found for theme '{theme.NAME}' with accent '{accent}' with type '{wall_type}'... Skipping"
        )
        return

    with open(CONFIG_TEMPLATE_PATH, "r") as f:
        template = f.read()

    new_file = template.replace(r"{{WALL_TYPE}}", wall_type).replace(
        r"{{WALL_NAME}}", wall_name
    )

    with open(CONFIG_PATH, "w") as f:
        f.write(new_file)

    run_shell_command(
        f"{SWWW_PATH} img {os.path.join(wallpapers_path, wall_name)} --transition-step 255"
    )
