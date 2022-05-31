import os

DNF_PROGRAMS = [
    'alacritty',
    'neofetch',
    'exa'
]


def check() -> None:
    """
    Install all my used programs
    """

    print('Installing programs\n')

    programs = ' '.join(DNF_PROGRAMS)
    dnf_program_install_command = f'sudo dnf install {programs}'

    os.system(dnf_program_install_command)

    print()

    powerline_install_command = 'sudo pip install powerline-shell'

    os.system(powerline_install_command)

    print('\nFinished installing programs\n')
