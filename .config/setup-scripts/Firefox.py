import os
import shutil
from Colorize import with_color, Color

HOME_DIR = os.getenv('HOME')
FIREFOX_CONF_DIR = os.path.join(HOME_DIR, '.config/firefox')
PROFILE_DIR = os.path.join(HOME_DIR, '.mozilla/firefox/fq92moem.default-release-1')
CHROME_DIR = os.path.join(PROFILE_DIR, 'chrome')


def check() -> None:
    """
    Makes sure that the Firefox configuration files exist and are up-to-date
    """
    print('Running Firefox check\n')

    # Make sure that the chrom folder exists
    if not os.path.exists(CHROME_DIR):
        os.mkdir(CHROME_DIR)
        print(with_color(f'{CHROME_DIR} created\n', Color.Yellow))

    # Config files already in firefox
    files_gotten = os.listdir(CHROME_DIR)

    for file in os.listdir(FIREFOX_CONF_DIR):
        # Fullpath to files
        needed_file_path = os.path.join(FIREFOX_CONF_DIR, file)
        gotten_file_path = os.path.join(CHROME_DIR, file)

        # Check config is already in firefox
        if file in files_gotten:
            # Lines of files
            needed_lines = open(needed_file_path, 'r').readlines()
            gotten_lines = open(gotten_file_path, 'r').readlines()

            # Making sure files are the same
            if needed_lines != gotten_lines:
                shutil.copy(needed_file_path, gotten_file_path)

                print(with_color(f'{file} updated\n', Color.Yellow))
            else:
                print(with_color(f'{file} check\n', Color.Green))

        else:  # Copy files from .config to firefox
            shutil.copy(needed_file_path, gotten_file_path)
            print(with_color(f'{file} created\n', Color.Yellow))

    print('Finished Firefox check\n')
