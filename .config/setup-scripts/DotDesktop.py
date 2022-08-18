import os
from configparser import ConfigParser, MissingSectionHeaderError

from Colorize import Color, with_color

BINARY_DIRECTORY = '.local/bin'
DOT_DESKTOP_FILE_DIRECTORY = '.local/share/applications'

user_dir = os.getenv('HOME')
programs_dir = os.path.join(user_dir, BINARY_DIRECTORY)
desktop_files_dir = os.path.join(user_dir, DOT_DESKTOP_FILE_DIRECTORY)

# Stats
dot_desktop_checked = set()
dot_desktop_updated = set()
dot_desktop_not_found = set()


def __get_filename_without_version(filename: str) -> str:
    """
    Removes the version at the end of a filename and returns it
    :param filename: The name of a file with a version at the end
    :return: The filename without the version
    """

    for char in filename[::-1]:
        if char.isdigit() or char == '.':
            filename = filename[:-1]
        else:
            return filename

    return filename


def __check_desktop_file(desktop_file_path: str) -> None:
    """
    Makes sure that path is correct

    :param desktop_file_path: Path to a *.desktop file
    """

    dot_desktop_file = desktop_file_path.split("/")[-1]
    print(with_color(f'Checking: {dot_desktop_file}', Color.Blue))

    config = ConfigParser(interpolation=None)

    # Disable behaviour where it makes entry keys lowercase
    config.optionxform = str

    try:
        config.read(desktop_file_path)
    except MissingSectionHeaderError:  # Thrown when the file at path is not a .desktop
        pass

    desktop_entry_section = 'Desktop Entry'
    entries_in_desktop = config[desktop_entry_section]
    if desktop_entry_section in config.sections() and 'Exec' in entries_in_desktop and 'Icon' in entries_in_desktop:
        for entry_key in ['Exec', 'Icon']:
            entry_path = entries_in_desktop[entry_key]

            """
            Entry path does not exists
            Could be because it isn't the .desktop file we are looking
            for or because folder was renamed
            """
            if not os.path.exists(entry_path):

                # Not the .desktop we are looking for
                if programs_dir not in entry_path:
                    print(with_color('Not a DVT .desktop\n', Color.Yellow))
                    return

                our_folder = entry_path.replace(programs_dir, '').split('/')[1]
                program_name = __get_filename_without_version(our_folder)

                # Look for program in .local/bin
                for dot_desktop_file in os.listdir(programs_dir):
                    if program_name in dot_desktop_file:  # Found program
                        new_path = entry_path.replace(our_folder, dot_desktop_file)

                        # Update path and write config to .desktop file
                        config[desktop_entry_section][entry_key] = new_path
                        with open(desktop_file_path, 'w') as desktop_file:
                            config.write(desktop_file)

                        dot_desktop_updated.add(desktop_file_path)
                        print(with_color(f'{entry_key} updated', Color.Cyan))
                        break

                else:  # The program does not exist in the .local/bin directory
                    dot_desktop_not_found.add(desktop_file_path)
                    print(with_color('Program not found\n', Color.Red))
                    return

            else:  # Program exists and everything is ok
                dot_desktop_checked.add(desktop_file_path)
                print(with_color(f'{entry_key} check', Color.Cyan))

    else:  # Might be a .desktop file but does not have the section we are looking for
        print(with_color('Not a valid .desktop file\n', Color.Yellow))
        return

    print(with_color('Done\n', Color.Green))


def __show_stats() -> None:
    """
    Show the user a tl;dr of what happened
    """

    print(with_color(f'{len(dot_desktop_not_found)} .desktop files have paths that do NOT exist', Color.Red))

    for dot_desktop_filepath in dot_desktop_not_found:
        filename = dot_desktop_filepath.split('/')[-1]
        print(f'\t{filename}')

    if len(dot_desktop_not_found) > 0:
        print()

    print(with_color(f'{len(dot_desktop_updated)} .desktop files were updated', Color.Yellow))
    print(with_color(f'{len(dot_desktop_checked)} .desktop files were already good to go\n', Color.Green))


def check() -> None:
    """
    Make sure all *.desktop files in ~/.local/share/application are pointing to their correct binaries
    """

    print('Running .desktop check\n')

    if not os.path.exists(programs_dir):
        os.mkdir(programs_dir)
        print(with_color('Download and install programs in local binary folder\n', Color.Red))
    else:
        for file in os.listdir(desktop_files_dir):
            if file.endswith('.desktop'):
                full_path = os.path.join(desktop_files_dir, file)
                __check_desktop_file(full_path)

        __show_stats()

    print('Finished .desktop check\n')
