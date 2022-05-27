from powerline_shell.themes.default import DefaultColor


class Color(DefaultColor):
    USERNAME_FG = 4
    USERNAME_BG = 15
    USERNAME_ROOT_BG = 1

    HOSTNAME_FG = 15
    HOSTNAME_BG = 4

    HOME_SPECIAL_DISPLAY = False
    PATH_FG = 4
    PATH_BG = 15
    CWD_FG = 4
    SEPARATOR_FG = 13

    READONLY_BG = 1
    READONLY_FG = 15

    REPO_CLEAN_BG = 2   # green
    REPO_CLEAN_FG = 0   # black
    REPO_DIRTY_BG = 1   # red
    REPO_DIRTY_FG = 15  # white

    JOBS_FG = 14
    JOBS_BG = 8

    CMD_PASSED_FG = 15
    CMD_PASSED_BG = 4
    CMD_FAILED_FG = 15
    CMD_FAILED_BG = 9

    SVN_CHANGES_BG = REPO_DIRTY_BG
    SVN_CHANGES_FG = REPO_DIRTY_FG

    VIRTUAL_ENV_BG = 2
    VIRTUAL_ENV_FG = 0

    AWS_PROFILE_FG = 14
    AWS_PROFILE_BG = 8

    TIME_FG = 8
    TIME_BG = 7
