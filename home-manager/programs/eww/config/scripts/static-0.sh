# vim:fileencoding=utf-8:foldmethod=marker

#: Brightness {{{

brightness=$(brightnessctl get)
max=$(brightnessctl max)
icons=("󰃚" "󰃛" "󰃜" "󰃝" "󰃞" "󰃟" "󰃠")

if [ $brightness -eq 0 ]; then
    icon=${icons[0]}
elif [ $brightness -eq $max ]; then
    icon=${icons[6]}
else
    # Calculate index based on brightness (1-$max maps to indices 1-5)
    # Formula: (brightness - 1) * 5 / $max + 1
    index=$(( (brightness - 1) * 5 / ( $max - 1 ) + 1 ))
    icon=${icons[$index]}
fi

a="$icon  $(printf '%4s' "$(echo "100*$(br)" | bc)%")"

#: }}}

#: Volume Source {{{

# Get volume level and mute status
volume=$(echo "$(vol src)*100/1" | bc)
muted=$(vol src -m)

# Check if muted
if [ "$muted" = "1" ]; then
    b="󰍮  - %"
else
    # Choose icon based on volume level
    if [ "$volume" -eq 0 ]; then
        icon="󰍭"
    else
        icon="󰍬"
    fi

    b="$icon $(printf '%4s' "$volume%")"
fi

#: }}}

#: Volume Sink {{{

# Get volume level and mute status
volume=$(echo "$(vol sink)*100/1" | bc)
muted=$(vol sink -m)

# Check if muted
if [ "$muted" = "1" ]; then
    c="󰝟  - %"
else
    # Choose icon based on volume level
    if [ "$volume" -eq 0 ]; then
        icon="󰸈"
    elif [ "$volume" -le 33 ]; then
        icon="󰕿"
    elif [ "$volume" -le 66 ]; then
        icon="󰖀"
    else
        icon="󰕾"
    fi

    c="$icon $(printf '%4s' "$volume%")"
fi

#: }}}

#: Battery {{{

CAP=$(cat /sys/class/power_supply/BAT0/capacity)
STATUS=$(cat /sys/class/power_supply/BAT0/status)

# Battery icons array (0-9% uses first icon, 10-19% uses second, etc.)
DISCHARGING_ICONS=("󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂")
CHARGING_ICONS=("󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋")

# Check battery status
if [ "$STATUS" = "Full" ] || ([ "$STATUS" = "Charging" ] && [ "$CAP" -eq 100 ]); then
    # Print empty string for full battery
    d=""
elif [ "$STATUS" = "Charging" ]; then
    # Calculate index (0-9) based on capacity for charging
    INDEX=$((CAP / 10))
    # Ensure index doesn't exceed array bounds
    if [ "$INDEX" -gt 9 ]; then
        INDEX=9
    fi
    ICON="${CHARGING_ICONS[$INDEX]}"
    d=" $ICON $CAP%"
else
    # Discharging or unknown status
    if [ "$CAP" -eq 100 ]; then
        ICON="󰁹"
    else
        # Calculate index (0-9) based on capacity
        INDEX=$((CAP / 10))
        # Ensure index doesn't exceed array bounds
        if [ "$INDEX" -gt 9 ]; then
            INDEX=9
        fi
        ICON="${DISCHARGING_ICONS[$INDEX]}"
    fi
    d=" $ICON $CAP%"
fi

#: }}}

echo "$a $b $c$d"
