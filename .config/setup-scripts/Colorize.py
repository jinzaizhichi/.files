from enum import Enum


class Color(Enum):
    NoColor = 0
    Black = 1
    Red = 2
    Green = 3
    Yellow = 4
    Blue = 5
    Magenta = 6  # Purple
    Cyan = 7
    White = 8


def __color_to_ansi(color: Color) -> str:
    if color == Color.NoColor:
        return '\033[0m'
    elif color == Color.Black:
        return '\033[0;30m'
    elif color == Color.Red:
        return '\033[0;31m'
    elif color == Color.Green:
        return '\033[0;32m'
    elif color == Color.Yellow:
        return '\033[0;33m'
    elif color == Color.Blue:
        return '\033[0;34m'
    elif color == Color.Magenta:
        return '\033[0;35m'
    elif color == Color.Cyan:
        return '\033[0;36m'
    elif color == Color.White:
        return '\033[0;37m'


def with_color(text: str, color: Color) -> str:
    """
    Adds color to the text passed using ANSI escape codes
    :param text: The text to add color to
    :param color: Color to change the text to
    :return: Text with ANSI color
    """

    return f'{__color_to_ansi(color)}{text}{__color_to_ansi(Color.NoColor)}'
