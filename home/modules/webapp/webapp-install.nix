{
  pkgs,
  ...
}:
pkgs.writeShellScriptBin "webapp-install" ''
    #!${pkgs.bash}/bin/bash
    set -euo pipefail

    # Black Don OS Web App Installer
    # Creates desktop entries for web applications using Chromium browser
    VERSION="1.0.0"

    # --- Helper Functions ---
    print_help() {
      echo "Black Don OS Web App Installer -- version $VERSION"
      echo ""
      echo "Usage: webapp-install [OPTIONS] [APP_NAME URL ICON_REF]"
      echo ""
      echo "Interactive Mode (no arguments):"
      echo "  webapp-install"
      echo ""
      echo "Direct Mode (3+ arguments):"
      echo "  webapp-install APP_NAME URL ICON_REF [CUSTOM_EXEC] [MIME_TYPES]"
      echo ""
      echo "Arguments:"
      echo "  APP_NAME     - Name of the web application"
      echo "  URL          - URL to open in the web app"
      echo "  ICON_REF     - Icon URL (PNG) or local filename in icons directory"
      echo "  CUSTOM_EXEC  - Optional custom execution command"
      echo "  MIME_TYPES   - Optional MIME types for file associations"
      echo ""
      echo "Options:"
      echo "  --help, -h   - Show this help message"
      echo ""
      echo "Examples:"
      echo "  webapp-install"
      echo "  webapp-install \"YouTube Music\" \"https://music.youtube.com\" \"https://example.com/icon.png\""
      echo ""
      echo "Icon resources:"
      echo "  https://dashboardicons.com"
      echo "  https://simpleicons.org"
      echo ""
    }

    # --- Main Logic ---
    if [ "$#" -eq 1 ] && [[ "$1" == "--help" || "$1" == "-h" ]]; then
      print_help
      exit 0
    fi

    if [ "$#" -lt 3 ]; then
      # Interactive mode
      echo -e "\e[32mLet's create a new web app you can start with the app launcher.\n\e[0m"

      APP_NAME=$(${pkgs.gum}/bin/gum input --prompt "Name> " --placeholder "My favorite web app")
      APP_URL=$(${pkgs.gum}/bin/gum input --prompt "URL> " --placeholder "https://example.com")
      ICON_REF=$(${pkgs.gum}/bin/gum input --prompt "Icon URL> " --placeholder "See https://dashboardicons.com (must use PNG!)")
      CUSTOM_EXEC=""
      MIME_TYPES=""
      INTERACTIVE_MODE=true
    else
      # Direct mode
      APP_NAME="$1"
      APP_URL="$2"
      ICON_REF="$3"
      CUSTOM_EXEC="''${4:-}" # Optional custom exec command
      MIME_TYPES="''${5:-}"  # Optional mime types
      INTERACTIVE_MODE=false
    fi

    # Ensure valid execution
    if [[ -z "$APP_NAME" || -z "$APP_URL" || -z "$ICON_REF" ]]; then
      echo "Error: You must set app name, app URL, and icon URL!" >&2
      exit 1
    fi

    # Create icon directory if it doesn't exist (using standard icon location)
    ICON_DIR="$HOME/.local/share/icons/hicolor/256x256/apps"
    mkdir -p "$ICON_DIR"

    # Create a sanitized icon name (replace spaces with dashes, lowercase)
    ICON_NAME=$(echo "$APP_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

    # Refer to local icon or fetch remotely from URL
    if [[ $ICON_REF =~ ^https?:// ]]; then
      ICON_FILE="$ICON_DIR/$ICON_NAME.png"
      echo "Downloading icon from $ICON_REF..."
      if ${pkgs.curl}/bin/curl -sL -o "$ICON_FILE" "$ICON_REF"; then
        echo "✓ Icon downloaded successfully to $ICON_FILE"
      else
        echo "Error: Failed to download icon." >&2
        exit 1
      fi
    else
      # Assume it's a local file reference
      if [[ "$ICON_REF" == /* ]]; then
        # Absolute path provided
        ICON_FILE="$ICON_DIR/$ICON_NAME.png"
        cp "$ICON_REF" "$ICON_FILE" || {
          echo "Error: Failed to copy icon from $ICON_REF" >&2
          exit 1
        }
      else
        # Relative filename - look in icon dir
        ICON_FILE="$ICON_DIR/$ICON_REF"
        if [ ! -f "$ICON_FILE" ]; then
          echo "Warning: Icon file $ICON_FILE does not exist" >&2
        fi
      fi
    fi

    # Use custom exec if provided, otherwise use Chromium in app mode
    if [[ -n $CUSTOM_EXEC ]]; then
      EXEC_COMMAND="$CUSTOM_EXEC"
    else
      # Chromium browser in app mode - creates a standalone window without browser UI
      EXEC_COMMAND="${pkgs.chromium}/bin/chromium --app=\"$APP_URL\""
    fi

    # Create application .desktop file
    DESKTOP_FILE="$HOME/.local/share/applications/$APP_NAME.desktop"

    echo "Creating desktop entry at $DESKTOP_FILE..."
    cat >"$DESKTOP_FILE" <<EOF
  [Desktop Entry]
  Version=1.0
  Name=$APP_NAME
  Comment=$APP_NAME
  Exec=$EXEC_COMMAND
  Terminal=false
  Type=Application
  Icon=$ICON_FILE
  StartupNotify=true
  Categories=WebApp;Network;
  EOF

    # Add mime types if provided
    if [[ -n $MIME_TYPES ]]; then
      echo "MimeType=$MIME_TYPES" >>"$DESKTOP_FILE"
    fi

    chmod +x "$DESKTOP_FILE"

    # Update icon cache
    ${pkgs.gtk3}/bin/gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor" 2>/dev/null || true

    echo "✓ Web app created successfully!"
    echo "  Desktop file: $DESKTOP_FILE"
    echo "  Icon: $ICON_FILE"

    if [[ $INTERACTIVE_MODE == true ]]; then
      echo -e "\nYou can now find $APP_NAME using the app launcher (SUPER + SPACE)"
      echo "or by searching for it in your application menu."
      echo ""
    fi
''
