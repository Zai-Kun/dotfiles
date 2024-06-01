from typing import Any


def base_update(colors: dict[str, Any], config_template_path: str, config_path: str):
    with open(config_template_path, "r") as f:
        template = f.read()

    for color, value in colors.items():
        place_holder = "{{" + color + "}}"
        hex = value["hex"]
        template = template.replace(place_holder, hex)

    with open(config_path, "w") as f:
        f.write(template)
