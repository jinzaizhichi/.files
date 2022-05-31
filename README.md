# Configuration files
The repo for my configuration files, all managed using this [guide](https://www.atlassian.com/git/tutorials/dotfiles)

## Shortcuts
1. [Installing](#installing)
2. [Icons and Mouse Cursors](#icons-and-mouse-cursors)
3. [Themes](#themes)

## Installing
Run the commands below
```bash
git clone --bare https://github.com/diego-velez/.files.git $HOME/.files
alias config='git --git-dir=$HOME/.files/ --work-tree=$HOME'
config checkout -f
config config --local status.showUntrackedFiles no
python .config/setup-scripts/main.py
```

## Icons and Mouse Cursors
User-wide directory: `~/.icons`
System-wide icons directory: `/usr/share/icons`

## Themes
User-wider directory: `~/.themes`
System-wide themes directory: `/usr/share/themes`
