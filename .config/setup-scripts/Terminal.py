import subprocess


def bkgd_run(command: str) -> subprocess.CompletedProcess:
    """
    Runs a terminal command and returns a subprocess.CompletedProcess object
    :param command: Command you want to run
    :return: subprocess.CompletedProcess object
    """

    command = command.split(' ')

    return subprocess.run(command, capture_output=True)


def run(command: str) -> int:
    """
    Runs a terminal command normally, and returns the return code of the command
    :param command: Command to run
    :return: Return code of command
    """

    command = command.split(' ')

    return subprocess.call(command)
