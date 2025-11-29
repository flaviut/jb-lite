# jb-lite

## Features

- Linux on ARM64 support
- Auto completion
- Not unreasonably bloated
- Optional auto-update

## Installation

Requires Python 3.13+.

### Install the CLI

Download the script to your local binary directory (ensure `~/.local/bin` is in your `$PATH`).

    mkdir -p ~/.local/bin
    curl -sL https://raw.githubusercontent.com/flaviut/jb-lite/main/jb-lite -o ~/.local/bin/jb-lite
    chmod +x ~/.local/bin/jb-lite

### Set up Shell Completion

**Bash** Add the following to your `~/.bashrc`:

    source <(jb-lite completion --shell bash)

**Zsh** Add the following to your `~/.zshrc`:

    autoload -U +X bashcompinit && bashcompinit
    source <(jb-lite completion --shell zsh)

### Enable Auto-Updates (Optional)

This sets up a systemd user timer to update your IDEs weekly (Wednesdays at 3 AM).

    mkdir -p ~/.config/systemd/user
    curl -sL https://raw.githubusercontent.com/flaviut/jb-lite/main/jb-lite-update.service -o ~/.config/systemd/user/jb-lite-update.service
    curl -sL https://raw.githubusercontent.com/flaviut/jb-lite/main/jb-lite-update.timer -o ~/.config/systemd/user/jb-lite-update.timer
    systemctl --user daemon-reload
    systemctl --user enable --now jb-lite-update.timer

## Usage

See `jb-lite help` for usage.

- `jb-lite list` to list availible IDEs
- `jb-lite install` to install a new IDE
