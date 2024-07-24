#!/bin/bash

# set explanation: https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
# set -euxo pipefail # print executed commands to the terminal
set -euo pipefail # don't print executed commands to the terminal

pipeline_upload() {
    local pipeline="$1"
    buildkite-agent pipeline upload "$pipeline" --log-level error
}

artifact_upload() {
    local artifact="$1"
    buildkite-agent artifact upload "$artifact" --log-level error
}

# echokite function to print text colors and styles
echokite () {
    local text="$1"
    local fg_color="$2"
    local bg_color="$3"
    local style="$4"

    local ansi_text="$text" # empty
    local ansi_fg_color="37" # white
    local ansi_bg_color="47" # white/none
    local ansi_style="0" # normal

    [ $style == "normal" ] && ansi_style="0"
    [ $style == "italic" ] && ansi_style="3"
    [ $style == "underline" ] && ansi_style="4"
    [ $style == "blink" ] && ansi_style="5"
    [ $style == "strike" ] && ansi_style="9"

    [ $fg_color == "black" ] && ansi_fg_color="30"
    [ $fg_color == "red" ] && ansi_fg_color="31"
    [ $fg_color == "green" ] && ansi_fg_color="32"
    [ $fg_color == "yellow" ] && ansi_fg_color="33"
    [ $fg_color == "blue" ] && ansi_fg_color="34"
    [ $fg_color == "magenta" ] && ansi_fg_color="35"
    [ $fg_color == "cyan" ] && ansi_fg_color="36"
    [ $fg_color == "white" ] && ansi_fg_color="37"
    [ $fg_color == "bright_black" ] && ansi_fg_color="90"
    [ $fg_color == "bright_red" ] && ansi_fg_color="91"
    [ $fg_color == "bright_green" ] && ansi_fg_color="92"
    [ $fg_color == "bright_yellow" ] && ansi_fg_color="93"
    [ $fg_color == "bright_blue" ] && ansi_fg_color="94"

    [ $bg_color == "none" ] && ansi_bg_color="47" # white renders nobackground
    [ $bg_color == "gray" ] && ansi_bg_color="40"
    [ $bg_color == "red" ] && ansi_bg_color="41"
    [ $bg_color == "green" ] && ansi_bg_color="42"

    echo -e "\033[${ansi_style};${ansi_fg_color};${ansi_bg_color}m${ansi_text}\033[0m"
    # echo -e "\033[${ansi_style};${ansi_fg_color};${ansi_bg_color}m${ansi_text}\033[0m" | sed -e '/^---\s\|^+++\s\|^~~~\s/!s/^/  /'
}

# replace_file_var function to replace variables in a file
replace_file_var () {
    local FILE_PATH="$1"
    local OLD_STRING="$2"
    local NEW_STRING="$3"

    if [ -f "$FILE_PATH" ]; then
        sed -i "s|$OLD_STRING|$NEW_STRING|g" "$FILE_PATH"
        echo "Replaced $OLD_STRING with $NEW_STRING"
    else
        echo "Error: File does not exist."
    fi
}
