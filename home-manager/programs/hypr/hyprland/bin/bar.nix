{pkgs}:
pkgs.writeShellScriptBin "bar" ''
  STATE_FILE="$XDG_RUNTIME_DIR/waybar_state"

  # Check for a valid argument
  if [ "$#" -ne 1 ]; then
      echo "Usage: $0 [0|1]"
      echo "  0: Hide Waybar"
      echo "  1: Unhide Waybar"
      exit 1
  fi

  ACTION=$1

  # Wait for the Waybar systemd service to be ready
  # We'll use a timeout to prevent the script from hanging indefinitely
  TIMEOUT=10
  ELAPSED=0
  while ! pgrep waybar > /dev/null && [ "$ELAPSED" -lt "$TIMEOUT" ]; do
      sleep 1
      ELAPSED=$((ELAPSED + 1))
  done

  # If Waybar isn't running after the timeout, exit
  if ! pgrep waybar > /dev/null; then
      echo "Error: Waybar service is not running after waiting for $TIMEOUT seconds."
      exit 1
  fi

  # If the state file doesn't exist, assume Waybar is hidden
  if [ ! -f "$STATE_FILE" ]; then
      echo "hidden" > "$STATE_FILE"
  fi

  CURRENT_STATE=$(cat "$STATE_FILE")

  if [ "$ACTION" -eq 0 ]; then
      # Hide Waybar
      if [ "$CURRENT_STATE" == "visible" ]; then
          pkill -SIGUSR1 waybar
          echo "hidden" > "$STATE_FILE"
      fi
  elif [ "$ACTION" -eq 1 ]; then
      # Unhide Waybar
      if [ "$CURRENT_STATE" == "hidden" ]; then
          pkill -SIGUSR1 waybar
          echo "visible" > "$STATE_FILE"
      fi
  else
      echo "Invalid argument. Use 0 to hide or 1 to unhide."
      exit 1
  fi
''
