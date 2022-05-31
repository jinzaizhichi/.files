import os
import subprocess
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
        return_code = subprocess.call(['which', program], stdout=open(os.devnull, "w"), stderr=subprocess.STDOUT)

        if return_code == 0:
            programs_installed.append(program)

    print(with_color(f'{", ".join(programs_installed)} already installed\n', Color.Green))

    for program in programs_installed:
        DNF_PROGRAMS.remove(program)

    if len(DNF_PROGRAMS) > 0:
        programs = ' '.join(DNF_PROGRAMS)
        dnf_program_install_command = ['sudo dnf install', programs]

        subprocess.call(dnf_program_install_command)

        print()

    # Check if powerline is installed
    program = 'powerline-shell'
    command = ['which', program]
    return_code = subprocess.call(command, stdout=open(os.devnull, "w"), stderr=subprocess.STDOUT)
    if return_code == 0:
        print(with_color(f'{program} already installed\n', Color.Green))
    else:
        powerline_install_command = ['sudo pip install', program]

        subprocess.call(powerline_install_command)

        print()

    print('Finished installing programs\n')
