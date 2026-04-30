#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

get_opt() {
    local name="$1"
    local default="$2"
    local value
    value=$(tmux show-option -gqv "$name")
    echo "${value:-$default}"
}

set_opt() {
    local name="$1"
    local value="$2"
    tmux set -g "$name" "$value"
}

set_optw() {
    local name="$1"
    local value="$2"
    tmux setw -g "$name" "$value"
}

set_vars() {
    # --- Icons ---
    ICON_SESSION=$(get_opt "@pwlite_icon_session" " ")

    # --- Separator ---
    SEPARATOR_SOLID_L=$(get_opt "@pwlite_separator_solid_l" "")
    SEPARATOR_SOLID_R=$(get_opt "@pwlite_separator_solid_r" "")
    SEPARATOR_THIN_L=$(get_opt "@pwlite_separator_thin_l" "")
    SEPARATOR_THIN_R=$(get_opt "@pwlite_separator_thin_r" "")

    # --- Format ---
    TIME_FORMAT=$(get_opt "@pwlite_time_format" "%H:%M")
    DATE_FORMAT=$(get_opt "@pwlite_date_format" "%Y-%m-%d")

    # --- Colors ---
    # Presets
    C_FG=$(get_opt "@pwlite_color_fg" "colour254")
    C_BG=$(get_opt "@pwlite_color_bg" "colour236")
    C_PRIMARY=$(get_opt "@pwlite_color_primary" "colour31")
    C_SECONDARY=$(get_opt "@pwlite_color_secondary" "colour81")
    C_LIGHTER=$(get_opt "@pwlite_color_lighter" "colour231")
    C_LIGHT=$(get_opt "@pwlite_color_light" "colour244")
    C_DARK=$(get_opt "@pwlite_color_dark" "colour237")
    C_DARKER=$(get_opt "@pwlite_color_darker" "colour236")
    C_ACCENT=$(get_opt "@pwlite_color_accent" "colour39")

    # Window (Normal)
    C_WIN_NORMAL_NUM=$(get_opt "@pwlite_color_win_normal_num" "$C_LIGHT")
    C_WIN_NORMAL_SEP=$(get_opt "@pwlite_color_win_normal_sep" "$C_LIGHTER")
    C_WIN_NORMAL_NAME=$(get_opt "@pwlite_color_win_normal_name" "$C_LIGHTER")
    C_WIN_NORMAL_BG=$(get_opt "@pwlite_color_win_normal_bg" "$C_DARK")

    # Window (Current)
    C_WIN_CURRENT_NUM=$(get_opt "@pwlite_color_win_current_num" "$C_SECONDARY")
    C_WIN_CURRENT_SEP=$(get_opt "@pwlite_color_win_current_sep" "$C_SECONDARY")
    C_WIN_CURRENT_NAME=$(get_opt "@pwlite_color_win_current_name" "$C_LIGHTER")
    C_WIN_CURRENT_BG=$(get_opt "@pwlite_color_win_current_bg" "$C_PRIMARY")

    # Session
    C_SESSION_NUM=$(get_opt "@pwlite_color_session_num" "$C_ACCENT")
    C_SESSION_NAME=$(get_opt "@pwlite_color_session_name" "$C_ACCENT")
    C_SESSION_BG=$(get_opt "@pwlite_color_session_bg" "$C_DARK")

    # Status
    C_STATUS_FG=$(get_opt "@pwlite_color_status_fg" "$C_LIGHTER")
    C_STATUS_BG=$(get_opt "@pwlite_color_status_bg" "$C_DARKER")

    # Pane Border
    C_PANE_BORDER_NORMAL_FG=$(get_opt "@pwlite_color_pane_border_normal_fg" "$C_DARKER")
    C_PANE_BORDER_ACTIVE_FG=$(get_opt "@pwlite_color_pane_border_active_fg" "$C_PRIMARY")

    # Display Pane
    C_DISPLAY_PANES_NORMAL_FG=$(get_opt "@pwlite_color_display_panes_normal_fg" "$C_FG")
    C_DISPLAY_PANES_ACTIVE_FG=$(get_opt "@pwlite_color_display_panes_active_fg" "$C_PRIMARY")

    # Prefix Highlight
    C_PREFIX_HIGHLIGHT_FG=$(get_opt "@pwlite_color_prefix_highlight_fg" "$C_LIGHTER")
    C_PREFIX_HIGHLIGHT_BG=$(get_opt "@pwlite_color_prefix_highlight_bg" "$C_PRIMARY")

    # Message
    C_MESSAGE_FG=$(get_opt "@pwlite_color_message_fg" "$C_LIGHTER")
    C_MESSAGE_BG=$(get_opt "@pwlite_color_message_bg" "$C_DARKER")
    C_MESSAGE_COMMAND_FG=$(get_opt "@pwlite_color_message_command_fg" "$C_PRIMARY")
    C_MESSAGE_COMMAND_BG=$(get_opt "@pwlite_color_message_command_bg" "$C_DARKER")

    # Clock Mode
    C_CLOCK_MODE=$(get_opt "@pwlite_color_clock_mode" "$C_PRIMARY")
}

# args:
#    direction: "L"|"R"
#    type     : "solid"|"thin"
#    fg       : e.g. colour31 or #eeeeee
#    bg       : e.g. colour31 or #555555
#    deco     : e.g. "nobold,noitalics,nounderscore"
separator() {
    local direction="${1:-L}"
    local type="${2:-thin}"
    local fg="$3"
    local bg="$4"
    local deco="${5:-nobold,noitalics,nounderscore}"

    local char

    if [[ "$type" == "solid" ]]; then
        [[ "$direction" == "L" ]] && char="$SEPARATOR_SOLID_L" || char="$SEPARATOR_SOLID_R"
    else
        [[ "$direction" == "L" ]] && char="$SEPARATOR_THIN_L" || char="$SEPARATOR_THIN_R"
    fi

    printf '#[fg=%s,bg=%s,%s]%s' "$fg" "$bg" "$deco" "$char"
}

set_status() {
    # Status
    session_name="#[fg=$C_SESSION_NAME,bg=$C_SESSION_BG,bold] $ICON_SESSION#S $(separator R solid "$C_SESSION_BG" "$C_STATUS_BG")"
    time="$(separator L thin "$C_LIGHT" "$C_DARK")#[fg=$C_STATUS_FG,bg=$C_DARK] $TIME_FORMAT"
    date="$(separator L thin "$C_LIGHT" "$C_DARK")#[fg=$C_STATUS_FG,bg=$C_DARK] $DATE_FORMAT"
    battery="$(separator L thin "$C_LIGHT" "$C_DARK")#[fg=$C_STATUS_FG,bg=$C_DARK] #{battery_color_charge_fg}#{battery_icon} #{battery_percentage}"
    # hostname="$(separator L solid "$C_DARKER" "$C_DARK")#H"
    set_opt "status-bg" "$C_STATUS_BG"
    set_opt "status-fg" "$C_STATUS_FG"
    set_opt "status-attr" "none"
    set_opt "status-left" "$session_name"
    set_opt "status-right" "#{prefix_highlight} $time $date $battery $hostname"
}

set_window() {
    # Window
    window_status_num_normal="$(separator R solid "$C_DARKER" "$C_WIN_NORMAL_BG") #[fg=$C_WIN_NORMAL_NUM,bg=$C_WIN_NORMAL_BG,nobold]#I"
    window_status_name_normal="#[fg=$C_WIN_NORMAL_NAME,bg=$C_WIN_NORMAL_BG]#W $(separator R solid "$C_WIN_NORMAL_BG" "$C_DARKER")"
    window_status_num_current="$(separator R solid $C_DARKER $C_WIN_CURRENT_BG) #[fg=$C_WIN_CURRENT_NUM,bg=$C_WIN_CURRENT_BG,bold]#I"
    window_status_name_current="#[fg=$C_WIN_CURRENT_NAME,bg=$C_WIN_CURRENT_BG,bold]#W $(separator R solid "$C_WIN_CURRENT_BG" "$C_DARKER")"
    set_opt "window-status-format" "$window_status_num_normal $window_status_name_normal"
    set_opt "window-status-current-format" "$window_status_num_current $window_status_name_current"
    set_opt "window-status-separator" ""
    set_optw "window-status-style" "fg=$C_WIN_NORMAL_NAME,bg=$C_WIN_NORMAL_BG"
    set_optw "window-status-current-style" "fg=$C_WIN_CURRENT_NAME,bg=$C_WIN_CURRENT_BG"
}

set_message() {
    # Messages
    set_opt "message-fg" "$C_MESSAGE_FG"
    set_opt "message-bg" "$C_MESSAGE_BG"
    set_opt "message-command-fg" "$C_MESSAGE_COMMAND_FG"
    set_opt "message-command-bg" "$C_MESSAGE_COMMAND_BG"
}

set_pane() {
    # Pane border
    set_opt "pane-border-style" "fg=$C_PANE_BORDER_NORMAL_FG"
    set_opt "pane-active-border-style" "fg=$C_PANE_BORDER_ACTIVE_FG"
    set_opt "display-panes-colour" "$C_DISPLAY_PANES_NORMAL_FG"
    set_opt "display-panes-active-colour" "$C_DISPLAY_PANES_ACTIVE_FG"
}

# Plugin supports
set_plugin() {
    # tmux-prefix-highlight
    set_opt "@prefix_highlight_show_copy_mode" 'on'
    set_opt "@prefix_highlight_fg" "$C_PREFIX_HIGHLIGHT_FG"
    set_opt "@prefix_highlight_bg" "$C_PREFIX_HIGHLIGHT_BG"
}

set_config() {
    # General
    set_opt "status-interval" 5
    set_opt "status" "on"
    set_opt "status-right-length" 50
    set_opt "status-left-length" 20

    # Window status alignment
    set_opt "status-justify" "left"

    set_optw "window-status-activity-style" none

    # Clock mode
    set_optw "clock-mode-colour" "$C_CLOCK_MODE"

}

main() {
    set_vars
    set_status
    set_window
    set_pane
    set_message
    set_plugin
    set_config
}

main
