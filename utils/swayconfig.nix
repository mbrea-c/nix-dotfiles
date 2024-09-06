{ outputs, workspaces, dwt, ... }:
let
  outputsConfig = outputs: # swayconfig
    builtins.foldl'
    (acc: { name, scale }: acc + "\n" + "output '${name}' scale ${scale}") ""
    outputs;
  workspaceConfig = workspaces:
    builtins.foldl' (acc:
      { name, outputList }:
      acc + "\n" + "workspace ${name} output ${
        builtins.foldl' (acc: outputName: acc + " " + "'${outputName}'") ""
        outputList
      }") "" workspaces;

  # swayconfig
in ''
  # -------------------------------------------------------
  # --- BASE CONFIG
  # -------------------------------------------------------
  # Update dbus environment, this fixes screensharing via xdg-desktop-portal-wlr
  exec dbus-update-activation-environment --all

  ### Output configuration

  # TODO: Default wallpaper could be handled by bgmanager:
  # exec_always bgmanager set_background
  output * {
     bg /home/manuel/Pictures/wallpapers/montana.jpg fill
  }

  ${outputsConfig outputs}
  ${workspaceConfig workspaces}

  ### Input configuration

  # Example configuration:


  input type:touchpad {
      # Disable while typing
      dwt ${if dwt then "enabled" else "disable"}
      tap enabled
      natural_scroll enabled
      middle_emulation enabled
      pointer_accel 0.7
      accel_profile adaptive
      click_method clickfinger
  }

  input type:keyboard {
      xkb_layout us
  }

  font sans-serif Regular 11

  # Cursor
  set $my_cursor Adwaita
  set $my_cursor_size 26
  seat seat0 xcursor_theme $my_cursor $my_cursor_size

  #
  # Window rules
  #
  # Firefox Microphone/webcam notifier should be floating and unfocused
  for_window [title="Firefox — Sharing Indicator"] floating enable
  for_window [title="Firefox — Sharing Indicator"] nofocus

  bar {
     swaybar_command waybar
  }

  # -------------------------------------------------------
  # --- AUTOSTART
  # -------------------------------------------------------
  exec sleep 5 && systemctl start --user sway-session.target

  # -------------------------------------------------------
  # --- KEYBINDS
  # -------------------------------------------------------
  input * xkb_options compose:ralt

  ### Variables
  #
  # Logo key. Use Mod1 for Alt, Mod4 for winkey
  set $mod Mod4
  # Home row direction keys, like vim
  set $left h
  set $down j
  set $up k
  set $right l
  # Your preferred terminal emulator
  set $term alacritty
  # Your preferred application launcher
  # Note: pass the final command to swaymsg so that the resulting window can be opened
  # on the original workspace that the command was run on.
  set $menu rofi -dmenu -matching fuzzy
  set $menu_launcher rofi -show drun -matching fuzzy -show-icons

  ### Key bindings
  #
  # Basics:
  #
      # Start a terminal
      bindsym $mod+Return exec $term

      # Start file manager
      bindsym $mod+r exec $term -e "lf"

      # Kill focused window
      bindsym $mod+q kill

      # Start your launcher
      bindsym $mod+d exec $menu_launcher

      # Enable/disable dwt
      bindsym $mod+z input type:touchpad dwt enabled
      bindsym $mod+Shift+z input type:touchpad dwt disabled

      # bindsym $mod+Shift+d exec dmenu-colored -g
      # bindsym $mod+e exec dmenu-colored -b
      # bindsym $mod+Shift+s exec toggle-ustatus status
      # bindsym $mod+Shift+n exec swaync-client -t -sw
      # bindsym $mod+backslash exec mbc-unicode-input -m normal


      # Drag floating windows by holding down $mod and left mouse button.
      # Resize them with right mouse button + $mod.
      # Despite the name, also works for non-floating windows.
      # Change normal to inverse to use left mouse button for resizing and right
      # mouse button for dragging.
      floating_modifier $mod normal

      # Reload the configuration file
      bindsym $mod+Shift+c reload

      # Exit sway (logs you out of your Wayland session)
      bindsym $mod+Shift+e exec dmenu-colored --power
      # Lock sway
      bindsym $mod+Shift+x exec wlock.sh
  #
  # Moving around:
  #
      # Move your focus around
      bindsym $mod+$left focus left
      bindsym $mod+$down focus down
      bindsym $mod+$up focus up
      bindsym $mod+$right focus right
      # Or use $mod+[up|down|left|right]
      bindsym $mod+Left focus left
      bindsym $mod+Down focus down
      bindsym $mod+Up focus up
      bindsym $mod+Right focus right

      # Move the focused window with the same, but add Shift
      bindsym $mod+Shift+$left move left
      bindsym $mod+Shift+$down move down
      bindsym $mod+Shift+$up move up
      bindsym $mod+Shift+$right move right
      # Ditto, with arrow keys
      bindsym $mod+Shift+Left move left
      bindsym $mod+Shift+Down move down
      bindsym $mod+Shift+Up move up
      bindsym $mod+Shift+Right move right
  #
  # Workspaces:
  #
      bindgesture swipe:3:right workspace prev
      bindgesture swipe:3:left workspace next

      bindsym --no-repeat $mod+o exec "toggle-sov";

      # Switch to workspace
      bindsym --no-repeat $mod+1 workspace number 1; exec "refresh-sov"
      bindsym --no-repeat $mod+2 workspace number 2; exec "refresh-sov"
      bindsym --no-repeat $mod+3 workspace number 3; exec "refresh-sov"
      bindsym --no-repeat $mod+4 workspace number 4; exec "refresh-sov"
      bindsym --no-repeat $mod+5 workspace number 5; exec "refresh-sov"
      bindsym --no-repeat $mod+6 workspace number 6; exec "refresh-sov"
      bindsym --no-repeat $mod+7 workspace number 7; exec "refresh-sov"
      bindsym --no-repeat $mod+8 workspace number 8; exec "refresh-sov"
      bindsym --no-repeat $mod+9 workspace number 9; exec "refresh-sov"
      bindsym --no-repeat $mod+0 workspace number 10;exec "refresh-sov"

      # Move focused container to workspace
      bindsym $mod+Shift+1 move container to workspace number 1
      bindsym $mod+Shift+2 move container to workspace number 2
      bindsym $mod+Shift+3 move container to workspace number 3
      bindsym $mod+Shift+4 move container to workspace number 4
      bindsym $mod+Shift+5 move container to workspace number 5
      bindsym $mod+Shift+6 move container to workspace number 6
      bindsym $mod+Shift+7 move container to workspace number 7
      bindsym $mod+Shift+8 move container to workspace number 8
      bindsym $mod+Shift+9 move container to workspace number 9
      bindsym $mod+Shift+0 move container to workspace number 10
      # Note: workspaces can have any name you want, not just numbers.
      # We just use 1-10 as the default.
  #
  # Layout stuff:
  #
      # You can "split" the current object of your focus with
      # $mod+b or $mod+v, for horizontal and vertical splits
      # respectively.
      bindsym $mod+b splith
      bindsym $mod+v splitv

      # Switch the current container between different layout styles
      bindsym $mod+s layout stacking
      bindsym $mod+w layout tabbed
      bindsym $mod+t layout toggle split

      # Make the current focus fullscreen
      bindsym $mod+f fullscreen

      # Toggle the current focus between tiling and floating mode
      bindsym $mod+Shift+space floating toggle

      # Swap focus between the tiling area and the floating area
      bindsym $mod+space focus mode_toggle

      # Move focus to the parent container
      bindsym $mod+a focus parent
  #
  # Scratchpad:
  #
      # Sway has a "scratchpad", which is a bag of holding for windows.
      # You can send windows there and get them back later.

      # Move the currently focused window to the scratchpad
      bindsym $mod+Shift+minus move scratchpad

      # Show the next scratchpad window or hide the focused scratchpad window.
      # If there are multiple scratchpad windows, this command cycles through them.
      bindsym $mod+minus scratchpad show

  #
  # Media keys:
  #
      # Volume control
      bindsym XF86AudioRaiseVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
      bindsym XF86AudioLowerVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bindsym XF86AudioMute exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindsym XF86AudioMicMute exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      bindsym XF86MonBrightnessUp exec brightnessctl set 5%+
      bindsym XF86MonBrightnessDown exec brightnessctl set 5%-

  #
  # Resizing containers:
  #
  mode "resize" {
      # left will shrink the containers width
      # right will grow the containers width
      # up will shrink the containers height
      # down will grow the containers height
      bindsym $left resize shrink width 10px
      bindsym $down resize grow height 10px
      bindsym $up resize shrink height 10px
      bindsym $right resize grow width 10px

      # Ditto, with arrow keys
      bindsym Left resize shrink width 10px
      bindsym Down resize grow height 10px
      bindsym Up resize shrink height 10px
      bindsym Right resize grow width 10px

      # Return to default mode
      bindsym Return mode "default"
      bindsym Escape mode "default"
  }
  bindsym $mod+Shift+r mode "resize"

  include /etc/sway/config.d/*
''
