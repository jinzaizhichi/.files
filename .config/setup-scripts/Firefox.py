import os
import shutil
from configparser import ConfigParser
from typing import Set
from Colorize import with_color, Color

HOME_DIR = os.getenv('HOME')
CONF_DIR = os.path.join(HOME_DIR, '.config/firefox')
FIREFOX_DIR = os.path.join(HOME_DIR, '.mozilla/firefox')


def __get_profiles() -> Set[str]:
    """
    Searches for all profile folders in the Firefox directory
    :return: Set of all profile folders
    """

    config = ConfigParser()

    # Disable behaviour where it makes entry keys lowercase
    config.optionxform = str

    profiles_dir = os.path.join(FIREFOX_DIR, 'profiles.ini')

    config.read(profiles_dir)

    result = set()

    for section in config:
        for key in config[section]:
            if key == 'Path':
                result.add(config[section][key])

    return result


def check() -> None:
    """
    Makes sure that the Firefox configuration files exist and are up-to-date
    """

    print('Running Firefox check\n')

    for profile_folder in __get_profiles():
        print(f'Checking {profile_folder}')

        profile_dir = os.path.join(FIREFOX_DIR, profile_folder)
        chrome_dir = os.path.join(profile_dir, 'chrome')

        # Make sure that the chrome  folder exists
        if not os.path.exists(chrome_dir):
            os.mkdir(chrome_dir)
            print(with_color(f'{chrome_dir} created', Color.Yellow))

        # Config files already in firefox
        files_gotten = os.listdir(chrome_dir)

        for file in os.listdir(CONF_DIR):
            # Skip README file
            if file == 'README.md':
                continue

            # Fullpath to files
            needed_file_path = os.path.join(CONF_DIR, file)
            gotten_file_path = os.path.join(chrome_dir, file)

            # Check config is already in firefox
            if file in files_gotten:
                # Lines of files
                needed_lines = open(needed_file_path, 'r').readlines()
                gotten_lines = open(gotten_file_path, 'r').readlines()

                # Making sure files are the same
                if needed_lines != gotten_lines:
                    shutil.copy(needed_file_path, gotten_file_path)

                    print(with_color(f'{file} updated', Color.Cyan))
                else:
                    print(with_color(f'{file} check', Color.Cyan))

            else:  # Copy files from .config to firefox
                shutil.copy(needed_file_path, gotten_file_path)
                print(with_color(f'{file} created', Color.Cyan))

        print(with_color('Done\n', Color.Green))

    print('Finished Firefox check\n')
