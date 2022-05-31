import subprocess


def run(command: str) -> subprocess.CompletedProcess:
    """
    Runs a terminal command and returns a subprocess.CompletedProcess object
    :param command: Command you want to run
    :return: subprocess.CompletedProcess object
    """

    command = command.split(' ')

    return subprocess.run(command, capture_output=True)
