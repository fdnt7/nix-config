output() {
  hyprctl activewindow -j | jq -r ".title // \"\""
}

handle() {
  case $1 in
    activewindowv2*)
      output
      ;;
  esac
}

output

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
