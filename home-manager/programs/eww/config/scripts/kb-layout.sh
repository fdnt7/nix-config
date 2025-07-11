handle() {
  case $1 in
    activelayout*)
      name=$(echo "$1" | sed 's/activelayout>>.*,\(.\{2\}\).*/\L\1/')
      if [ -n "$name" ]; then
        echo "  $name"
      else
        echo ""
      fi
      ;;
  esac
}

hyprctl devices -j | jq -r '.keyboards[] | select(.name == "at-translated-set-2-keyboard") | .active_keymap' | sed 's/\(.\{2\}\).*/  \L\1/'

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
