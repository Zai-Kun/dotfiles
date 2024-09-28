import os
from typing import Any

from _base import run_shell_command

NAME = "catppuccin_mocha"
MULTIPLE_ACCENTS = True
GTK_ICON_THEME = "Papirus-Dark"
GTK_THEME = "catppuccin-mocha-{accent}-standard+default"

COLORS = {
    "rosewater": {
        "hex": "#f5e0dc",
        "rgb": {"r": 245, "g": 224, "b": 220},
        "accent": True,
    },
    "flamingo": {
        "hex": "#f2cdcd",
        "rgb": {"r": 242, "g": 205, "b": 205},
        "accent": True,
    },
    "pink": {"hex": "#f5c2e7", "rgb": {"r": 245, "g": 194, "b": 231}, "accent": True},
    "mauve": {"hex": "#cba6f7", "rgb": {"r": 203, "g": 166, "b": 247}, "accent": True},
    "red": {"hex": "#f38ba8", "rgb": {"r": 243, "g": 139, "b": 168}, "accent": True},
    "maroon": {"hex": "#eba0ac", "rgb": {"r": 235, "g": 160, "b": 172}, "accent": True},
    "peach": {"hex": "#fab387", "rgb": {"r": 250, "g": 179, "b": 135}, "accent": True},
    "yellow": {"hex": "#f9e2af", "rgb": {"r": 249, "g": 226, "b": 175}, "accent": True},
    "green": {"hex": "#a6e3a1", "rgb": {"r": 166, "g": 227, "b": 161}, "accent": True},
    "teal": {"hex": "#94e2d5", "rgb": {"r": 148, "g": 226, "b": 213}, "accent": True},
    "sky": {"hex": "#89dceb", "rgb": {"r": 137, "g": 220, "b": 235}, "accent": True},
    "sapphire": {
        "hex": "#74c7ec",
        "rgb": {"r": 116, "g": 199, "b": 236},
        "accent": True,
    },
    "blue": {"hex": "#89b4fa", "rgb": {"r": 137, "g": 180, "b": 250}, "accent": True},
    "lavender": {
        "hex": "#b4befe",
        "rgb": {"r": 180, "g": 190, "b": 254},
        "accent": True,
    },
    "text": {"hex": "#cdd6f4", "rgb": {"r": 205, "g": 214, "b": 244}, "accent": False},
    "subtext1": {
        "hex": "#bac2de",
        "rgb": {"r": 186, "g": 194, "b": 222},
        "accent": False,
    },
    "subtext0": {
        "hex": "#a6adc8",
        "rgb": {"r": 166, "g": 173, "b": 200},
        "accent": False,
    },
    "overlay2": {
        "hex": "#9399b2",
        "rgb": {"r": 147, "g": 153, "b": 178},
        "accent": False,
    },
    "overlay1": {
        "hex": "#7f849c",
        "rgb": {"r": 127, "g": 132, "b": 156},
        "accent": False,
    },
    "overlay0": {
        "hex": "#6c7086",
        "rgb": {"r": 108, "g": 112, "b": 134},
        "accent": False,
    },
    "surface2": {
        "hex": "#585b70",
        "rgb": {"r": 88, "g": 91, "b": 112},
        "accent": False,
    },
    "surface1": {"hex": "#45475a", "rgb": {"r": 69, "g": 71, "b": 90}, "accent": False},
    "surface0": {"hex": "#313244", "rgb": {"r": 49, "g": 50, "b": 68}, "accent": False},
    "base": {"hex": "#1e1e2e", "rgb": {"r": 30, "g": 30, "b": 46}, "accent": False},
    "mantle": {"hex": "#181825", "rgb": {"r": 24, "g": 24, "b": 37}, "accent": False},
    "crust": {"hex": "#11111b", "rgb": {"r": 17, "g": 17, "b": 27}, "accent": False},
}


def gtk(accent: str, extra_info: dict[str, Any], _: dict[str, Any]):
    # GTK theme
    theme_name = GTK_THEME.format(accent=accent)
    if theme_name in os.listdir(extra_info["themes_folder"]):
        run_shell_command(extra_info["gtk_command"].format("gtk-theme", theme_name))
    else:
        yield f"No GTK theme found for catppuccin_mocha_{accent}... skipping"

    if GTK_ICON_THEME not in os.listdir(extra_info["icons_folder"]):
        yield f"Icon theme {GTK_ICON_THEME} not found... skipping"
        return

    run_shell_command(extra_info["gtk_command"].format("icon-theme", GTK_ICON_THEME))

    # GTK icon theme
    folder_theme = [
        theme.strip()
        for theme in run_shell_command("papirus-folders -l").stdout.splitlines()
        if theme.strip().startswith("cat") and "mocha" in theme and accent in theme
    ]
    if not folder_theme:
        yield f"Theme catppuccin_mocha_{accent} not found in papirus-folders... skipping"
        return

    run_shell_command(f"papirus-folders -C {folder_theme[0]} --theme {GTK_ICON_THEME}")
