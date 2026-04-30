# TODO

- [ ] **feature:** Restructure color variables
- [ ] **fix:** Check if `tmux-battery` is installed
- [ ] **chore:** Remove some config from `set_config` (Should be changed by `.tmux.conf`)
- [ ] **feat:** Enable tmux-prefix-highlight with `#{prefix_highlight}`
- [ ] **feat:** Enable hostname
- [ ] **feat:** Add session num (with @show-session-num option)
- [ ] **docs:** Add some color variations for `@pwlite_color_primary/secondary/accent`
- [ ] Displaying `battery` or not depends on user (Should be modifiable)


## Colors structure

| Category   | Title                       | Bash Varriable     | Tmux Variable                     | Note                                 |
| ---------- | --------------------------- | ------------------ | --------------------------------- | ------------------------------------ |
|  Main     | Background                  | C_BG               | @pwlite_color_bg                  |                                      |
|  Main     | Foreground                  | C_FG               | @pwlite_color_fg                  |                                      |
|  Session  | Session Background          | C_SESS_BG          | @pwlite_color_session_bg          |                                      |
|  Session  | Session Foreground          | C_SESS_FG          | @pwlite_color_session_fg          | Can be overwritten by below 3 colors |
|  Session  | Session Icon                | C_SESS_ICON        | @pwlite_color_session_icon        |                                      |
|  Session  | Session Index               | C_SESS_ID          | @pwlite_color_session_id          |                                      |
|  Session  | Session Title               | C_SESS_TITLE       | @pwlite_color_session_title       |                                      |
|  Window   | Window Background           | C_WIN_BG           | @pwlite_color_window_bg           |                                      |
|  Window   | Window Foreground           | C_WIN_FG           | @pwlite_color_window_fg           | Can be overwritten by below 3 colors |
|  Window   | Winows Icon                 | C_WIN_ICON         | @pwlite_color_window_icon         |                                      |
|  Window   | Window Index                | C_WIN_ID           | @pwlite_color_window_id           |                                      |
|  Window   | Window Title                | C_WIN_TITLE        | @pwlite_color_window_title        |                                      |
|  Window * | Window Active Background    | C_WIN_ACTIVE_BG    | @pwlite_color_window_active_bg    |                                      |
|  Window * | Window Active Foreground    | C_WIN_ACTIVE_FG    | @pwlite_color_window_active_fg    | Can be overwritten by below 3 colors |
|  Window * | Window Active Icon          | C_WIN_ACTIVE_ICON  | @pwlite_color_window_active_icon  |                                      |
|  Window * | Window Active Index         | C_WIN_ACTIVE_ID    | @pwlite_color_window_active_id    |                                      |
|  Window * | Window Active Title         | C_WIN_ACTIVE_TITLE | @pwlite_color_window_active_title |                                      |
|  Widget   | Widget Background           | C_DTM_BG           | @pwlite_color_widget_bg           | = C_BG (default)                     |
|  Widget   | Widget Foreground           | C_DTM_FG           | @pwlite_color_widget_fg           | = C_FG (default)                     |
|  Widget   | Widget Separator Foreground | C_DTM_SEP_FG       | @pwlite_color_widget_separator    | Graish                               |

- [ ] Apply them into code.
- [ ] Apply them into `README.md`.
- [ ] How is `tmux-battery` background ?