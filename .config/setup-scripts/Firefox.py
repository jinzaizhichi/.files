import os
import shutil
from configparser import ConfigParser
from typing import Set

from Colorize import with_color, Color

HOME_DIR = os.getenv('HOME')
CONF_DIR = os.path.join(HOME_DIR, '.config/firefox')
FIREFOX_DIR = os.path.join(HOME_DIR, '.mozilla/firefox')

"""
If need to change about:config preferences, then use:
https://askubuntu.com/questions/313483/how-do-i-change-firefoxs-aboutconfig-from-a-shell-script
http://kb.mozillazine.org/User.js_file
"""


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


def __check_folder(path: str, profile: str) -> None:
    """
    Makes sure that the folder passed and everything in it is in the Firefox directory
    :param path: Folder to check is in Firefox
    :param profile: Where to check the folder is in
    """

    for root, folders, files in os.walk(path):
        relative_path = root.replace(path, '').replace('/', '')

        for folder in folders:
            destination_fullpath = os.path.join(profile, relative_path, folder)

            # Make sure all folders exist
            if not os.path.exists(destination_fullpath):
                os.mkdir(destination_fullpath)
                print(with_color(f'Created {folder} folder', Color.Cyan))
            else:
                print(with_color(f'{folder} check', Color.Green))

        for file in files:
            # Do not copy README to Firefox profile
            if file == 'README.md':
                continue

            destination_fullpath = os.path.join(profile, relative_path, file)
            source_fullpath = os.path.join(root, file)

            # Make sure all files exist
            if not os.path.exists(destination_fullpath):
                shutil.copy(source_fullpath, destination_fullpath)

                print(with_color(f'Copied {file} file', Color.Cyan))
                continue

            destination_file = open(destination_fullpath, 'r').readlines()
            source_file = open(source_fullpath, 'r').readlines()

            # Make sure files are the same
            if source_file != destination_file:
                shutil.copy(source_fullpath, destination_fullpath)
                print(with_color(f'Updated {file}', Color.Cyan))
            else:
                print(with_color(f'{file} check', Color.Green))


def check() -> None:
    """
    Apply all Firefox configuration files in ~/.config/firefox
    """

    print('Running Firefox check\n')

    for profile_folder in __get_profiles():
        print(with_color(f'Checking {profile_folder}', Color.Blue))

        profile_path = os.path.join(FIREFOX_DIR, profile_folder)
        __check_folder(CONF_DIR, profile_path)

        print(with_color('Done\n', Color.Green))

    print('Finished Firefox check\n')
