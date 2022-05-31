import os
from Colorize import with_color, Color

DNF_PROGRAMS = [
    'alacritty',
    'neofetch',
    'exa',
    'pip',
]


def check() -> None:
    """
    Install all my used programs
    """

    print('Installing programs\n')

    # Check which programs are installed and remove them from the list
    programs_installed = list()
    for program in DNF_PROGRAMS:
        return_code = os.system(f'which {program}')

        if return_code == 0:
            print(with_color(f'{program} already installed\n', Color.Green))
            programs_installed.append(program)

    for program in programs_installed:
        DNF_PROGRAMS.remove(program)

    if len(DNF_PROGRAMS) > 0:
        programs = ' '.join(DNF_PROGRAMS)
        dnf_program_install_command = f'sudo dnf install {programs}'

        os.system(dnf_program_install_command)

        print()

    # Check if powerline is installed
    program = 'powerline-shell'
    if os.system(f'which {program}') == 0:
        print(with_color(f'{program} already installed\n', Color.Green))
    else:
        powerline_install_command = f'sudo pip install {program}'

        os.system(powerline_install_command)

        print()

    print('Finished installing programs\n')
