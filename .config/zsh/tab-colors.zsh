# iTerm2 Tab Color Functions
_tab_color_completions() {
  compadd red orange yellow green blue purple magenta cyan pink lime teal indigo brown gray white
}
compdef _tab_color_completions set_tab_color set_all_tabs_color

# Set the tab color using iTerm2 proprietary escape codes
set_tab_color() {
  local color="${1:-red}"

  # Color definitions (RGB values 0-255)
  case "$color" in
    # Basic colors matching iTerm2 preset colors
    red)     local r=255 g=0   b=0   ;;
    orange)  local r=255 g=165 b=0   ;;
    yellow)  local r=255 g=255 b=0   ;;
    green)   local r=0   g=255 b=0   ;;
    blue)    local r=0   g=0   b=255 ;;
    purple)  local r=128 g=0   b=128 ;;
    magenta) local r=255 g=0   b=255 ;;

    # Additional useful colors
    cyan)    local r=0   g=255 b=255 ;;
    pink)    local r=255 g=192 b=203 ;;
    lime)    local r=191 g=255 b=0   ;;
    teal)    local r=0   g=128 b=128 ;;
    indigo)  local r=75  g=0   b=130 ;;
    brown)   local r=165 g=42  b=42  ;;
    gray)    local r=128 g=128 b=128 ;;
    white)   local r=255 g=255 b=255 ;;

    # Custom RGB format: "123,45,67"
    *,*,*)
      local r=$(echo "$color" | cut -d',' -f1)
      local g=$(echo "$color" | cut -d',' -f2)
      local b=$(echo "$color" | cut -d',' -f3)

      # Validate RGB values
      if [[ ! "$r" =~ ^[0-9]+$ ]] || [[ ! "$g" =~ ^[0-9]+$ ]] || [[ ! "$b" =~ ^[0-9]+$ ]] ||
         [ "$r" -gt 255 ] || [ "$g" -gt 255 ] || [ "$b" -gt 255 ]; then
        echo "❌ Invalid RGB values. Use format: R,G,B (0-255)"
        return 1
      fi
      ;;

    *)
      echo "❌ Unknown color: $color"
      echo ""
      echo "Available preset colors:"
      echo "  red, orange, yellow, green, blue, purple, magenta"
      echo "  cyan, pink, lime, teal, indigo, brown, gray, white"
      echo ""
      echo "Or use custom RGB format: R,G,B (e.g., '100,200,150')"
      return 1
      ;;
  esac

  # Set color on all sessions in the current tab (so split panes stay consistent)
  local ttys
  ttys=$(osascript -e '
    tell application "iTerm2"
      tell current tab of current window
        set ttyList to {}
        repeat with s in sessions
          set end of ttyList to tty of s
        end repeat
        set AppleScript'"'"'s text item delimiters to ","
        return ttyList as text
      end tell
    end tell
  ' 2>/dev/null)

  if [ -n "$ttys" ]; then
    IFS=',' read -rA tty_array <<< "$ttys"
    for tty in "${tty_array[@]}"; do
      tty=$(echo "$tty" | xargs)
      if [ -w "$tty" ]; then
        printf "\033]6;1;bg;red;brightness;%d\a" "$r" > "$tty"
        printf "\033]6;1;bg;green;brightness;%d\a" "$g" > "$tty"
        printf "\033]6;1;bg;blue;brightness;%d\a" "$b" > "$tty"
      fi
    done
  else
    # Fallback: set current session only
    echo -ne "\033]6;1;bg;red;brightness;$r\a"
    echo -ne "\033]6;1;bg;green;brightness;$g\a"
    echo -ne "\033]6;1;bg;blue;brightness;$b\a"
  fi

  echo "✅ Set tab color to: $color (RGB: $r,$g,$b)"
}

# Reset tab color to default
reset_tab_color() {
  local ttys
  ttys=$(osascript -e '
    tell application "iTerm2"
      tell current tab of current window
        set ttyList to {}
        repeat with s in sessions
          set end of ttyList to tty of s
        end repeat
        set AppleScript'"'"'s text item delimiters to ","
        return ttyList as text
      end tell
    end tell
  ' 2>/dev/null)

  if [ -n "$ttys" ]; then
    IFS=',' read -rA tty_array <<< "$ttys"
    for tty in "${tty_array[@]}"; do
      tty=$(echo "$tty" | xargs)
      if [ -w "$tty" ]; then
        printf "\033]6;1;bg;*;default\a" > "$tty"
      fi
    done
  else
    echo -ne "\033]6;1;bg;*;default\a"
  fi

  echo "✅ Reset tab color to default"
}

# Set all tabs in current window to the same color
set_all_tabs_color() {
  local color="${1:-red}"
  local r g b

  # Parse color and get RGB values
  case "$color" in
    # Basic colors matching iTerm2 preset colors
    red)     r=255 g=0   b=0   ;;
    orange)  r=255 g=165 b=0   ;;
    yellow)  r=255 g=255 b=0   ;;
    green)   r=0   g=255 b=0   ;;
    blue)    r=0   g=0   b=255 ;;
    purple)  r=128 g=0   b=128 ;;
    magenta) r=255 g=0   b=255 ;;
    cyan)    r=0   g=255 b=255 ;;
    pink)    r=255 g=192 b=203 ;;
    lime)    r=191 g=255 b=0   ;;
    teal)    r=0   g=128 b=128 ;;
    indigo)  r=75  g=0   b=130 ;;
    brown)   r=165 g=42  b=42  ;;
    gray)    r=128 g=128 b=128 ;;
    white)   r=255 g=255 b=255 ;;

    # Custom RGB format: "123,45,67"
    *,*,*)
      r=$(echo "$color" | cut -d',' -f1)
      g=$(echo "$color" | cut -d',' -f2)
      b=$(echo "$color" | cut -d',' -f3)

      # Validate RGB values
      if [[ ! "$r" =~ ^[0-9]+$ ]] || [[ ! "$g" =~ ^[0-9]+$ ]] || [[ ! "$b" =~ ^[0-9]+$ ]] ||
         [ "$r" -gt 255 ] || [ "$g" -gt 255 ] || [ "$b" -gt 255 ]; then
        echo "❌ Invalid RGB values. Use format: R,G,B (0-255)"
        return 1
      fi
      ;;

    *)
      echo "❌ Unknown color: $color"
      echo ""
      echo "Available preset colors:"
      echo "  red, orange, yellow, green, blue, purple, magenta"
      echo "  cyan, pink, lime, teal, indigo, brown, gray, white"
      echo ""
      echo "Or use custom RGB format: R,G,B (e.g., '100,200,150')"
      return 1
      ;;
  esac

  # Get all session ttys via AppleScript and send escape codes to each
  local ttys
  ttys=$(osascript -e '
    tell application "iTerm2"
      tell current window
        set ttyList to {}
        repeat with t in tabs
          repeat with s in sessions of t
            set end of ttyList to tty of s
          end repeat
        end repeat
        set AppleScript'"'"'s text item delimiters to ","
        return ttyList as text
      end tell
    end tell
  ' 2>/dev/null)

  if [ -n "$ttys" ]; then
    local count=0
    IFS=',' read -rA tty_array <<< "$ttys"
    for tty in "${tty_array[@]}"; do
      tty=$(echo "$tty" | xargs)  # trim whitespace
      if [ -w "$tty" ]; then
        printf "\033]6;1;bg;red;brightness;%d\a" "$r" > "$tty"
        printf "\033]6;1;bg;green;brightness;%d\a" "$g" > "$tty"
        printf "\033]6;1;bg;blue;brightness;%d\a" "$b" > "$tty"
        count=$((count + 1))
      fi
    done
    echo "✅ Set $count session(s) to color: $color (RGB: $r,$g,$b)"
  else
    echo "⚠️  Could not get session ttys, setting current tab only"
    set_tab_color "$color"
  fi
}

# Reset all tabs to default color
reset_all_tabs_color() {
  local ttys
  ttys=$(osascript -e '
    tell application "iTerm2"
      tell current window
        set ttyList to {}
        repeat with t in tabs
          repeat with s in sessions of t
            set end of ttyList to tty of s
          end repeat
        end repeat
        set AppleScript'"'"'s text item delimiters to ","
        return ttyList as text
      end tell
    end tell
  ' 2>/dev/null)

  if [ -n "$ttys" ]; then
    local count=0
    IFS=',' read -rA tty_array <<< "$ttys"
    for tty in "${tty_array[@]}"; do
      tty=$(echo "$tty" | xargs)
      if [ -w "$tty" ]; then
        printf "\033]6;1;bg;*;default\a" > "$tty"
        count=$((count + 1))
      fi
    done
    echo "✅ Reset $count session(s) to default color"
  else
    echo -ne "\033]6;1;bg;*;default\a"
    echo "✅ Reset tab color to default"
  fi
}
