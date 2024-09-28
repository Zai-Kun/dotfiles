import importlib.util
import json
import os
import sys
from types import ModuleType
from typing import Any

from _shared import logger

if not os.path.exists("config.json"):
    logger.critical("No config file found (config.json)")
    sys.exit()

config = json.load(open("config.json"))


def import_module(module_name: str) -> ModuleType | None:
    module_path = f"{module_name}.py"
    spec = importlib.util.spec_from_file_location(module_name, module_path)
    if not spec:
        logger.error(f"'spec' is {spec} for {module_name}... skipping")
        return None
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)  # type:ignore

    return module


def import_and_update(
    module_name,
    theme: ModuleType,
    accent: str | None,
    extra_options: None | dict[str, Any],
):
    module = import_module(module_name)
    if module and hasattr(module, "update"):
        module.update(theme, accent, extra_options)
    else:
        logger.error(
            f"'update' function not found in '{module_name}.py' or failed to import... skipping"
        )


def update_theme(
    theme: ModuleType,
    accent: str | None,
    extra_options: None | dict[str, dict[str, Any]],
):
    current_file = os.path.basename(__file__)

    for file in os.listdir("./"):
        if (
            file.endswith(".py")
            and file != current_file
            and file.split(".")[0] not in config.get("exclude", [])
            and not file.startswith("_")
        ):
            module_name = os.path.splitext(file)[0]
            extra_opts = extra_options.get(module_name) if extra_options else None
            import_and_update(module_name, theme, accent, extra_opts)


if __name__ == "__main__":
    theme = import_module(f'themes/{config["theme"]}')
    if not theme:
        sys.exit()
    if theme.MULTIPLE_ACCENTS:
        if not (accent := config.get("accent")):
            logger.error(
                f"This theme ({config['theme']}) supports multiple accent but none were defined in your config."
            )
            sys.exit()
        if not (_accent := theme.COLORS.get(accent)) or not _accent["accent"]:
            logger.error(f"Accent '{accent}' not found for theme '{config['theme']}'")
            sys.exit()
    else:
        accent = None

    update_theme(
        theme,
        accent,
        config.get("extra_options"),
    )
