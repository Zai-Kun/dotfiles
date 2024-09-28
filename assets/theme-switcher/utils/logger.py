import logging
import sys

from colorama import Fore, Style, init

init(autoreset=True)

UNDERLINE = "\033[4m"


class CustomFormatter(logging.Formatter):
    """Custom logging formatter with colors and dynamic formatting."""

    LOG_COLORS = {
        logging.DEBUG: Fore.BLUE + Style.BRIGHT,
        logging.INFO: Fore.GREEN + Style.BRIGHT,
        logging.WARNING: Fore.YELLOW + Style.BRIGHT,
        logging.ERROR: Fore.RED + Style.BRIGHT,
        logging.CRITICAL: Fore.RED + Style.BRIGHT + UNDERLINE,
    }

    def format(self, record):
        log_color = self.LOG_COLORS.get(record.levelno)
        log_format = (
            f"{log_color}[%(levelname)s] [%(filename)s:%(lineno)d] - %(message)s"
        )

        formatter = logging.Formatter(log_format, datefmt="%Y-%m-%d %H:%M:%S")
        return formatter.format(record)


def get_custom_logger(name: str):
    """Returns a logger with the custom formatter."""
    logger = logging.getLogger(name)

    if not logger.hasHandlers():
        console_handler = logging.StreamHandler(sys.stdout)
        console_handler.setLevel(logging.DEBUG)

        console_handler.setFormatter(CustomFormatter())

        logger.addHandler(console_handler)

    logger.setLevel(logging.DEBUG)
    return logger


if __name__ == "__main__":
    logger = get_custom_logger("MyCustomLogger")

    logger.debug("This is a debug message")
    logger.info("Informational message")
    logger.warning("This is a warning!")
    logger.error("An error occurred")
    logger.critical("Critical issue!")
