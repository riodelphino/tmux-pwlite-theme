#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PWLITE_CONFIG="config.conf"

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
    tmux set -gq "$name" "$value"
}

set_vars() {
    # --- Separator ---
    SEPARATOR_SOLID_L=$(get_opt "@separator_solid_l" "")
    SEPARATOR_SOLID_R=$(get_opt "@separator_solid_r" "")
    SEPARATOR_THIN_L=$(get_opt "@separator_thin_l" "")
    SEPARATOR_THIN_R=$(get_opt "@separator_thin_r" "")

    # --- Colors ---
    # Presets
    C_PRIMARY=$(get_opt "@color_primary" "colour31")
    C_SECONDARY=$(get_opt "@color_secondary" "colour81")
    C_LIGHTER=$(get_opt "@color_lighter" "colour231")
    C_LIGHT=$(get_opt "@color_light" "colour244")
    C_DARK=$(get_opt "@color_dark" "colour237")
    C_DARKER=$(get_opt "@color_darker" "colour236")
    C_ACCENT=$(get_opt "@color_accent" "colour208")

    # Window (Active)
    C_WIN_ACTIVE_NUM=$(get_opt "@color_win_active_num" "$C_SECONDARY")
    C_WIN_ACTIVE_SEP=$(get_opt "@color_win_active_sep" "$C_SECONDARY")
    C_WIN_ACTIVE_NAME=$(get_opt "@color_win_active_name" "$C_LIGHTER")
    C_WIN_ACTIVE_BG=$(get_opt "@color_win_active_bg" "$C_PRIMARY")

    # Window (Normal)
    C_WIN_NORMAL_NUM=$(get_opt "@color_win_normal_num" "$C_LIGHT")
    C_WIN_NORMAL_SEP=$(get_opt "@color_win_normal_sep" "$C_LIGHTER")
    C_WIN_NORMAL_NAME=$(get_opt "@color_win_normal_name" "$C_LIGHTER")
    C_WIN_NORMAL_BG=$(get_opt "@color_win_normal_bg" "$C_DARK")

    # Session
    C_SESSION_NUM=$(get_opt "@color_session_num" "$C_ACCENT")
    C_SESSION_NAME=$(get_opt "@color_session_name" "$C_ACCENT")
    C_SESSION_BG=$(get_opt "@color_session_bg" "white")

    # Status
    C_STATUS_FG=$(get_opt "@color_status_fg" "$C_LIGHTER")
    C_STATUS_BG=$(get_opt "@color_status_bg" "$C_DARKER")

    # Pane Border
    C_PANE_BORDER_ACTIVE_FG=$(get_opt "@color_pane_border_active_fg" "$C_LIGHTER")
    C_PANE_BORDER_NORMAL_FG=$(get_opt "@color_pane_border_normal_fg" "$C_DARKER")

    # Prefix Highlight
    C_PREFIX_HIGHLIGHT_FG=$(get_opt "@color_prefix_highlight_fg" "$C_LIGHTER")
    C_PREFIX_HIGHLIGHT_BG=$(get_opt "@color_prefix_highlight_bg" "$C_PRIMARY")

    # Message
    C_MESSAGE_FG=$(get_opt "@color_message_fg" "$C_LIGHTER")
    C_MESSAGE_BG=$(get_opt "@color_message_bg" "$C_DARKER")
    C_MESSAGE_COMMAND_FG=$(get_opt "@color_message_command_fg" "$C_PRIMARY")
    C_MESSAGE_COMMAND_BG=$(get_opt "@color_message_command_bg" "$C_DARKER")

    # Clock Mode
    C_CLOCK_MODE=$(get_opt "@color_clock_mode" "$C_PRIMARY")
}

unset_vars() {
    unset CURRENT_DIR

    unset PWLITE_CONFIG

    # --- Separator ---
    unset SEPARATOR_SOLID_L
    unset SEPARATOR_SOLID_R
    unset SEPARATOR_THIN_L
    unset SEPARATOR_THIN_R

    # --- Colors ---
    # Presets
    unset C_PRIMARY
    unset C_SECONDARY
    unset C_LIGHTER
    unset C_LIGHT
    unset C_DARK
    unset C_DARKER
    unset C_ACCENT
    # C_ACCENT

    # Window (Active)
    unset C_WIN_ACTIVE_NUM
    unset C_WIN_ACTIVE_SEP
    unset C_WIN_ACTIVE_NAME
    unset C_WIN_ACTIVE_BG

    # Window (Normal)
    unset C_WIN_NORMAL_NUM
    unset C_WIN_NORMAL_SEP
    unset C_WIN_NORMAL_NAME
    unset C_WIN_NORMAL_BG

    # Session
    unset C_SESSION_NUM
    unset C_SESSION_NAME
    unset C_SESSION_BG

    # Status
    unset C_STATUS_FG
    unset C_STATUS_BG

    # Pane Border
    unset C_PANE_BORDER_ACTIVE_FG
    unset C_PANE_BORDER_NORMAL_FG

    # Prefix Highlight
    unset C_PREFIX_HIGHLIGHT_FG
    unset C_PREFIX_HIGHLIGHT_BG

    # Message
    unset C_MESSAGE_FG
    unset C_MESSAGE_BG
    unset C_MESSAGE_COMMAND_FG
    unset C_MESSAGE_COMMAND_BG

    # Clock Mode
    unset C_CLOCK_MODE
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
    session_name="#[fg=$C_SESSION_NAME,bg=$C_SESSION_BG,bold] #S $(separator R solid "$C_SESSION_BG" "$C_STATUS_BG")"
    time="$(separator L thin $C_LIGHT $C_DARK)#[fg=$C_STATUS_FG,bg=$C_DARK] %H:%M"
    day="$(separator L thin $C_LIGHT $C_DARK)#[fg=$C_STATUS_FG,bg=$C_DARK] %Y-%m-%d"
    battery="$(separator L thin $C_LIGHT $C_DARK)#[fg=$C_STATUS_FG,bg=$C_DARK] #{battery_color_charge_fg}#{battery_icon} #{battery_percentage}"
    set_opt status-left "$session_name"
    set_opt status-right "#{prefix_highlight} $time $day $battery $hostname"
}

set_window() {
    # Window
    window_status_num_normal="$(separator R solid $C_DARKER $C_WIN_NORMAL_BG) #[fg=$C_WIN_NORMAL_NUM,bg=$C_WIN_NORMAL_BG,nobold]#I"
    window_status_name_normal="#[fg=$C_WIN_NORMAL_NAME,bg=$C_WIN_NORMAL_BG]#W $(separator R solid $C_WIN_NORMAL_BG $C_DARKER)"
    window_status_num_active="$(separator R solid $C_DARKER $C_WIN_ACTIVE_BG) #[fg=$C_WIN_ACTIVE_NUM,bg=$C_WIN_ACTIVE_BG,bold]#I"
    window_status_name_active="#[fg=$C_WIN_ACTIVE_NAME,bg=$C_WIN_ACTIVE_BG,bold]#W $(separator R solid $C_WIN_ACTIVE_BG $C_DARKER)"
    set_opt window-status-format "$window_status_num_normal $window_status_name_normal"
    set_opt window-status-current-format "$window_status_num_active $window_status_name_active"
    set_opt window-status-separator ""
}

main() {
    set_vars
    tmux source-file "$CURRENT_DIR/$PWLITE_CONFIG"

    set_status
    set_window

    unset_vars
}

main
