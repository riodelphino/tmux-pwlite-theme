# tmux-pwlite-theme

Powerline-styled tmux theme.

Forked from [cryptomilk/tmux-cryptomilk-theme](https://github.com/cryptomilk/tmux-cryptomilk-theme).  
Inspired by [tmux-dark-plus-theme](https://github.com/khanghh/tmux-dark-plus-theme).

## Features

- Light weight (Low CPU consumption)
- Easy config via tmux @options

<p align="center"><img src="./screenshots/tmux-pwlite-theme-screenshot-01.png"/></p>

This screenshot is displaying:
- [tmux-battery](https://github.com/tmux-plugins/tmux-battery) on `status_right`


## Installation

### Install using [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

1. Add plugin to the list of TPM plugins in `.tmux.conf`:

        set -g @plugin 'riodelphino/tmux-pwlite-theme'

2. Hit `prefix + I` to fetch the plugin and source it. The theme should now be working.

### Install manually

1. Clone repo to local machine:

        git clone https://github.com/riodelphino/tmux-pwlite-theme \
            ~/.config/tmux/themes/tmux-pwlite-theme

2. Add this line to the bottom of your `~/.tmux.conf`:

        run-shell "~/.config/tmux/themes/tmux-pwlite-theme/pwlite.tmux"

3. Reload your `~/.tmux.conf`:

        tmux source-file ~/.tmux.conf

## License

MIT License. See [LICENSE](./LICENSE)