"""
1. disable previous login manager using: grep 'ExecStart=' /etc/systemd/system/display-manager.service to check the current one
2. install sddm and enable it
3. install a theme
"""
import os.path

import Terminal
from Colorize import with_color, Color

display_manager_service_path = '/etc/systemd/system/display-manager.service'
# The variable that the display manager is assigned to
display_manager_key = 'ExecStart'
desired_display_manager = 'sddm'
libraries_needed = ['qt5-qtgraphicaleffects', 'qt5-qtquickcontrols2', 'qt5-qtsvg']
path_to_theme = os.getenv('HOME') + '/.config/sddm-theme/sugar-candy'
theme_name = path_to_theme.split('/')[-1]
dm_theme_dir = '/usr/share/sddm/themes/'
theme_config_file = '/etc/sddm.conf'
custom_theme_config_file = os.getenv('HOME') + '/.config/sddm-theme/sddm.conf'


def __get_current_display_manager() -> [str | None]:
    output = Terminal.bkgd_run('systemctl status display-manager')

    try:
        return output.stdout.decode('UTF-8').split('\n')[0].split(' ')[1].replace('.service', '').strip()
    except IndexError:
        return None


def __disable_current_display_manager() -> None:
    """
    Makes sure that there is no display manager enabled, will disable the current one if it is not the one desired
    """

    current_display_manager = __get_current_display_manager()
    if __get_current_display_manager() is None:
        print(with_color('There is no display manager enabled', Color.Yellow))
    elif current_display_manager != desired_display_manager:
        print(f'Current display manager is {current_display_manager}')
        output = Terminal.bkgd_run(f'systemctl disable {current_display_manager}')
        if output.returncode == 0:
            print(with_color(f'Disabled {current_display_manager}', Color.Cyan))


def __enable_desired_display_manager() -> None:
    """
    Enables the desired display manager
    """

    if __get_current_display_manager() != desired_display_manager:
        output = Terminal.bkgd_run(f'systemctl enable {desired_display_manager}')
        if output.returncode == 0:
            print(with_color(f'Enabled {desired_display_manager}', Color.Cyan))


def __apply_theme() -> None:
    theme_path = dm_theme_dir + theme_name
    if os.path.exists(path_to_theme) and not os.path.exists(theme_path):
        Terminal.run(f'sudo cp -r {path_to_theme} {theme_path}')

    Terminal.run(f"sudo cp {custom_theme_config_file} {theme_config_file}")


def check() -> None:
    """
    Install and enable SDDM
    """

    print("Running display manager check\n")

    if __get_current_display_manager() == desired_display_manager:
        print(with_color(f'{desired_display_manager} is already enabled', Color.Cyan))
    else:
        __disable_current_display_manager()

        return_code = Terminal.bkgd_run(f'which {desired_display_manager}').returncode
        if return_code != 0:
            command = f'sudo dnf install -y {desired_display_manager}'
            for library in libraries_needed:
                command += ' ' + library
            Terminal.run(command)
        else:
            print(with_color(f'{desired_display_manager} is already installed', Color.Cyan))

        __enable_desired_display_manager()

    __apply_theme()

    print(with_color('Finished display manager check\n', Color.Green))
