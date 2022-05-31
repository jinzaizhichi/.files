import Terminal
from Colorize import with_color, Color

DNF_PROGRAMS = [
    'alacritty',
    'neofetch',
    'exa',
    'pip',
    'keepassxc',
]


def check() -> None:
    """
    Install all my used programs
    """

    print('Installing programs\n')

    # Check which programs are installed and remove them from the list
    programs_installed = list()
    for program in DNF_PROGRAMS:
        return_code = Terminal.run(f'which {program}').returncode

        if return_code == 0:
            programs_installed.append(program)

    if len(programs_installed) > 0:
        print(with_color(f'{", ".join(programs_installed)} already installed\n', Color.Green))

        for program in programs_installed:
            DNF_PROGRAMS.remove(program)

    if len(DNF_PROGRAMS) > 0:
        Terminal.run(f'sudo dnf install {DNF_PROGRAMS}')

        print()

    # Check if powerline is installed
    program = 'powerline-shell'
    return_code = Terminal.run(f'which {program}').returncode

    if return_code == 0:
        print(with_color(f'{program} already installed\n', Color.Green))
    else:
        Terminal.run(f'sudo pip install {program}')

        print()

    print('Finished installing programs\n')
