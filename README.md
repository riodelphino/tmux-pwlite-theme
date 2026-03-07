# tmux-pwlite-theme

Powerline-styled tmux theme.

Forked from [cryptomilk/tmux-cryptomilk-theme](https://github.com/cryptomilk/tmux-cryptomilk-theme).  
Inspired by [tmux-dark-plus-theme](https://github.com/khanghh/tmux-dark-plus-theme).

## Features

- Light weight (Low CPU consumption)
- Easy config via tmux @options

![Screenshot](./screenshots/tmux-pwlite-theme-screenshot-01.png)

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

## Configuration

Set option:
```tmux
# Set color name
set -g @pwlite_color_win_normal_bg "colour237"
# Set RGB color code
set -g @pwlite_color_win_normal_bg "#3a3a3a"
```
Unset the option:
```tmux
# Use default value
set -gu @pwlite_color_win_normal_bg
```

### Separators

| Option Name               | Default |
| ------------------------- | ------- |
| @pwlite_separator_solid_l |        |
| @pwlite_separator_solid_r |        |
| @pwlite_separator_thin_l  |        |
| @pwlite_separator_thin_r  |        |

### Colors

Color options
| Category         | Option Name                         | Default        |
| ---------------- | ----------------------------------- | -------------- |
| Presets          |                                     |                |
|                  | @pwlite_color_primary               | colour31       |
|                  | @pwlite_color_secondary             | colour81       |
|                  | @pwlite_color_lighter               | colour231      |
|                  | @pwlite_color_light                 | colour244      |
|                  | @pwlite_color_dark                  | colour237      |
|                  | @pwlite_color_darker                | colour236      |
|                  | @pwlite_color_accent                | colour208      |
| Window (Active)  |                                     |                |
|                  | @pwlite_color_win_active_num        | @color_primary |
|                  | @pwlite_color_win_active_sep        | @color_primary |
|                  | @pwlite_color_win_active_name       | @color_lighter |
|                  | @pwlite_color_win_active_bg         | @color_primary |
| Window (Normal)  |                                     |                |
|                  | @pwlite_color_win_normal_num        | @color_light   |
|                  | @pwlite_color_win_normal_sep        | @color_lighter |
|                  | @pwlite_color_win_normal_name       | @color_lighter |
|                  | @pwlite_color_win_normal_bg         | @color_dark    |
| Session          |                                     |                |
|                  | @pwlite_color_session_num           | @color_accent  |
|                  | @pwlite_color_session_name          | @color_accent  |
|                  | @pwlite_color_session_bg            | white          |
| Status           |                                     |                |
|                  | @pwlite_color_status_fg             | @color_lighter |
|                  | @pwlite_color_status_bg             | @color_darker  |
| Pane Border      |                                     |                |
|                  | @pwlite_color_pane_border_active_fg | @color_lighter |
|                  | @pwlite_color_pane_border_normal_fg | @color_darker  |
| Prefix Highlight |                                     |                |
|                  | @pwlite_color_prefix_highlight_fg   | @color_lighter |
|                  | @pwlite_color_prefix_highlight_bg   | @color_primary |
| Message          |                                     |                |
|                  | @pwlite_color_message_fg            | @color_lighter |
|                  | @pwlite_color_message_bg            | @color_darker  |
|                  | @pwlite_color_message_command_fg    | @color_primary |
|                  | @pwlite_color_message_command_bg    | @color_darker  |
| Clock Mode       |                                     |                |
|                  | @pwlite_color_clock_mode            | @color_primary |


## License

MIT License. See [LICENSE](./LICENSE)