import DotDesktop
import Firefox

"""
ONLY UPDATE THIS LIST

List of the modules that you want to run the check of
"""
CHECKING_FUNCTIONS = [
    DotDesktop.check,
    Firefox.check
]

if __name__ == '__main__':
    for index, function in enumerate(CHECKING_FUNCTIONS):
        function()

        if index != len(CHECKING_FUNCTIONS) - 1:
            print('#' * 100, end='\n\n')
