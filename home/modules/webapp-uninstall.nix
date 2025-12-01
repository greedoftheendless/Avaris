{
  pkgs,
  ...
}:
pkgs.writeShellScriptBin "webapp-remove" ''
  #!${pkgs.bash}/bin/bash
  set -euo pipefail

  VERSION="1.0.0"

  # --- Helper Functions ---
  print_help() {
    echo "Black Don OS Web App Removal Tool -- version $VERSION"
    echo ""
    echo "Usage: webapp-remove [APP_NAME]"
    echo ""
    echo "Interactive Mode (no arguments):"
    echo "  webapp-remove"
    echo "  - Lists all installed webapps and lets you select one to remove"
    echo ""
    echo "Direct Mode:"
    echo "  webapp-remove \"App Name\""
    echo "  - Removes the specified webapp"
    echo ""
    echo "Options:"
    echo "  --help, -h   - Show this help message"
    echo "  --list, -l   - List all installed webapps"
    echo ""
  }

  list_webapps() {
    echo "Installed webapps:"
    if [ -d "$HOME/.local/share/applications" ]; then
      for desktop in "$HOME/.local/share/applications"/*.desktop; do
        if [ -f "$desktop" ]; then
          # Check if it's a webapp (has WebApp category)
          if grep -q "Categories=.*WebApp" "$desktop" 2>/dev/null; then
            name=$(basename "$desktop" .desktop)
            url=$(grep "^Exec=" "$desktop" | sed 's/.*--app="\([^"]*\)".*/\1/' || echo "N/A")
            echo "  • $name ($url)"
          fi
        fi
      done
    else
      echo "  No webapps found"
    fi
  }

  remove_webapp() {
    local app_name="$1"
    local desktop_file="$HOME/.local/share/applications/$app_name.desktop"
    local icon_name=$(echo "$app_name" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
    local icon_file="$HOME/.local/share/icons/hicolor/256x256/apps/$icon_name.png"

    if [ ! -f "$desktop_file" ]; then
      echo "Error: Webapp '$app_name' not found" >&2
      echo "Available webapps:" >&2
      list_webapps >&2
      return 1
    fi

    echo "Removing webapp: $app_name"

    # Remove desktop file
    if [ -f "$desktop_file" ]; then
      rm "$desktop_file"
      echo "✓ Removed desktop entry: $desktop_file"
    fi

    # Remove icon file
    if [ -f "$icon_file" ]; then
      rm "$icon_file"
      echo "✓ Removed icon: $icon_file"
    fi

    # Update icon cache
    ${pkgs.gtk3}/bin/gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor" 2>/dev/null || true

    echo "✓ Webapp '$app_name' removed successfully!"
  }

  # --- Main Logic ---
  if [ "$#" -eq 1 ]; then
    case "$1" in
      --help|-h)
        print_help
        exit 0
        ;;
      --list|-l)
        list_webapps
        exit 0
        ;;
      *)
        # Direct mode with app name
        remove_webapp "$1"
        exit 0
        ;;
    esac
  fi

  if [ "$#" -eq 0 ]; then
    # Interactive mode
    echo "Available webapps to remove:"
    echo ""

    # Build array of webapp names
    webapps=()
    if [ -d "$HOME/.local/share/applications" ]; then
      for desktop in "$HOME/.local/share/applications"/*.desktop; do
        if [ -f "$desktop" ]; then
          if grep -q "Categories=.*WebApp" "$desktop" 2>/dev/null; then
            name=$(basename "$desktop" .desktop)
            webapps+=("$name")
          fi
        fi
      done
    fi

    if [ ''${#webapps[@]} -eq 0 ]; then
      echo "No webapps found to remove."
      exit 0
    fi

    # Use gum to select webapp to remove
    selected=$(printf '%s\n' "''${webapps[@]}" | ${pkgs.gum}/bin/gum choose --header "Select webapp to remove:")

    if [ -n "$selected" ]; then
      echo ""
      remove_webapp "$selected"
    else
      echo "No webapp selected. Cancelled."
    fi
  else
    echo "Error: Invalid arguments" >&2
    print_help
    exit 1
  fi
''
