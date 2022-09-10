import Terminal
from Colorize import Color, with_color

"""
Icons, cursors and themes that should be applied

Icons and cursors should be installed in ~/.icons
Desktop, window borders and controls theme should be installed in ~/.themes
"""
ICONS = 'McMojave-circle-green'
CURSOR = 'Bibata-Modern-Ice'
DESKTOP = 'Dracula'
WINDOW_BORDERS = 'Dracula'
CONTROLS = 'Dracula'

"""
Commands:
    Controls:
        org.cinnamon.desktop.interface gtk-theme 'Dracula'

    Window borders:
        org.cinnamon.desktop.wm.preferences theme 'Dracula'

    Desktop:
        org.cinnamon.theme name 'Dracula'

    Icons:
        org.cinnamon.desktop.interface icon-theme 'McMojave-circle-green'

    Cursor:
        org.cinnamon.desktop.interface cursor-theme 'Bibata-Modern-Ice'
"""


def __check_setting(name: str, setting: str, value: str) -> None:
    """
    Makes sure that the setting is set to the correct value, if not change it
    :param name: Section name
    :param setting: gsettings schemadir
    :param value: What the setting should be set to
    """

    result = Terminal.bkgd_run(f'gsettings get {setting}')
    output = result.stdout.decode('UTF-8').strip()[1:-1]
    if output != value:
        Terminal.bkgd_run(f'gsettings set {setting} {value}')
        print(f'Changing from: {with_color(output, Color.Red)} to {with_color(value, Color.Green)}\n')
    else:
        print(with_color(f'{name} check\n', Color.Green))


def check() -> None:
    """
    Apply all Cinnamon settings like icons and themes
    """

    print('Running Cinnamon settings check\n')

    __check_setting('Icons', 'org.cinnamon.desktop.interface icon-theme', ICONS)
    __check_setting('Cursor', 'org.cinnamon.desktop.interface cursor-theme', CURSOR)
    __check_setting('Desktop', 'org.cinnamon.theme name', DESKTOP)
    __check_setting('Window Borders', 'org.cinnamon.desktop.wm.preferences theme', WINDOW_BORDERS)
    __check_setting('Controls', 'org.cinnamon.desktop.interface gtk-theme', CONTROLS)

    print('Done\n')
