handle() {
  case $1 in
    submap*)
      # Extract the name after "submap>>"
      name=$(echo "$1" | sed 's/^submap>>//')
      if [ -n "$name" ]; then
        echo "󰍍 $name"
      else
        echo ""
      fi
      ;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
