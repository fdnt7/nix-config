# vim:fileencoding=utf-8:foldmethod=marker

#: Lock Key {{{

map_leds() { sed 's/0/-/g; s/1/x/g'; }
a="󰞙 $(getleds n | map_leds) 󰘲 $(getleds c | map_leds) 󰞒 $(getleds s | map_leds)"

#: }}}

#: Trackpad {{{

STATUS_FILE="$XDG_RUNTIME_DIR/touchpad.status"

if ! [ -f "$STATUS_FILE" ]; then
  STATUS="-"
else
  if [ $(cat "$STATUS_FILE") = "true" ]; then
    STATUS="x"
  elif [ $(cat "$STATUS_FILE") = "false" ]; then
    STATUS="-"
  fi
fi

b="󰟸 $STATUS"

#: }}}

echo $a $b
