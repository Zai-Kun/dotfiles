from types import ModuleType
from typing import Any

from _shared import logger

GTK_COMMAND = 'gsettings set org.gnome.desktop.interface {} "{}"'
THEMES_FOLDER = "/usr/share/themes"
ICONS_FOLDER = "/usr/share/icons"


def update(theme: ModuleType, accent: str | None, extra_opts: dict[str, Any]):
    if hasattr(theme, "gtk"):
        for error_msg in theme.gtk(
            accent,
            {
                "gtk_command": GTK_COMMAND,
                "themes_folder": THEMES_FOLDER,
                "icons_folder": ICONS_FOLDER,
            },
            extra_opts,
        ):
            if not error_msg:
                break
            logger.error(error_msg)

        return

    # will fix this code when i add a theme other than catppuccin

    # themes = set(
    #     [
    #         theme
    #         for theme in os.listdir(THEMES_FOLDER)
    #         if flavour in theme and "hdpi" not in theme
    #     ]
    # )
    #
    # theme_found = False
    # for theme in themes:
    #     if color in theme.split("-"):
    #         run_shell_command(GTK_COMMAND.format("gtk-theme", theme))
    #         theme_found = True
    #         break
    #
    # if not theme_found:
    #     print(f"ERROR: Theme {flavour}-{color} not found for GTK... skipping")
    #
    # if ICON_THEME_NAME not in os.listdir(ICONS_FOLDER):
    #     print(f"ERROR: Icon theme {ICON_THEME_NAME}not found... skipping")
    #     return
    #
    # run_shell_command(GTK_COMMAND.format("icon-theme", ICON_THEME_NAME))
    #
    # folder_theme = [
    #     theme.strip()
    #     for theme in run_shell_command("papirus-folders -l").stdout.splitlines()
    #     if theme.strip().startswith("cat") and flavour in theme and color in theme
    # ]
    # if not folder_theme:
    #     print(
    #         f"ERROR: Theme {flavour}-{color} not found for papirus-folders... skipping"
    #     )
    #     return
    # run_shell_command(f"papirus-folders -C {folder_theme[0]} --theme {ICON_THEME_NAME}")
