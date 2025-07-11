output() {
  hyprctl workspaces -j | jq -r ".[].name" | while read -r name; do
    case "$name" in
      #"1")      		echo -n "󰖟 " ;;
      #"3")      		echo -n "󰅴 " ;;
      #"5")      		echo -n " " ;;
      #"6")      		echo -n "󰙽 " ;;
      #"8")      		echo -n "󰊖 " ;;
      "10")     		echo -n "0 " ;;
      #"special:chat")     	echo -n "󰍥 " ;;
      #"special:music")    	echo -n "󰝚 " ;;
      #"special:minimised")	echo -n " " ;;
      #"special:scratch")  	echo -n " " ;;
      "special:chat")     	echo -n "󰌍 " ;;
      "special:music")    	echo -n "= " ;;
      "special:minimised")	echo -n "- " ;; 
      "special:scratch")  	echo -n "\` " ;;
      *)                  	echo -n "$name " ;;
    esac
  done
  echo
}

handle() {
  case $1 in
    workspacev2*|activespecialv2*)
      output
      ;;
  esac
}

output

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
