{config, pkgs, ...}: {

  wayland.windowManager.hyprland.settings = {
    "$terminal" = "kitty";
    "$fileManager" = "thunar";
    "$menu" = "tofi-run";

    exec-once = [
      "waybar"
      "hyprpaper"
    ];

    general = {
      # Nord-ish border colors
      "col.active_border" = "rgba(88c0d0ff) rgba(81a1c1ff) 45deg";
      "col.inactive_border" = "rgba(4c566aff)";

      border_size = 2;
      gaps_in = 5;
      gaps_out = 10;
    };

    decoration = {
      rounding = 10;
      rounding_power = 2;

      active_opacity = 1.0;
      inactive_opacity = 1.0;

      shadow = {
        enabled = true;
        range = 4;
        render_power = 3;

        # Nord Polar Night shadow
        color = "rgba(1a1a1aee)";
      };

      blur = {
        enabled = true;
        size = 3;
        passes = 1;
        vibrancy = 0.1696;
      };
    };

    animations = {
      enabled = true;

      bezier = [
        "easeOutQuint, 0.23, 1, 0.32, 1"
        "easeInOutCubic, 0.65, 0.05, 0.36, 1"
        "linear, 0, 0, 1, 1"
        "almostLinear, 0.5, 0.5, 0.75, 1"
        "quick, 0.15, 0, 0.1, 1"
      ];

      animation = [
        "global, 1, 10, default"
        "border, 1, 5.39, easeOutQuint"
        "windows, 1, 4.79, easeOutQuint"
        "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
        "windowsOut, 1, 1.49, linear, popin 87%"
        "fadeIn, 1, 1.73, almostLinear"
        "fadeOut, 1, 1.46, almostLinear"
        "fade, 1, 3.03, quick"
        "layers, 1, 3.81, easeOutQuint"
        "layersIn, 1, 4, easeOutQuint, fade"
        "layersOut, 1, 1.5, linear, fade"
        "fadeLayersIn, 1, 1.79, almostLinear"
        "fadeLayersOut, 1, 1.39, almostLinear"
        "workspaces, 1, 1.94, almostLinear, fade"
        "workspacesIn, 1, 1.21, almostLinear, fade"
        "workspacesOut, 1, 1.94, almostLinear, fade"
        "zoomFactor, 1, 7, quick"
      ];
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    misc = {
      force_default_wallpaper = 0;
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
    };

    xwayland = {
      force_zero_scaling = true;
    };
  };
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";

    bind = [
      "SUPER_SHIFT, Q, killactive,"
        "$mainMod, M, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"
        ", PRINT, exec, XDG_CURRENT_DESKTOP=sway flameshot gui --path ~/Pictures/screenshots"
        "SHIFT, PRINT, exec, XDG_CURRENT_DESKTOP=sway flameshot gui -c"

        "$mainMod, V, togglefloating,"
        "$mainMod, D, exec, $menu"
        "$mainMod, P, pseudo,"
        "$mainMod, W, layoutmsg, togglesplit"
        "$mainMod, E, togglegroup"
        "$mainMod, I, changegroupactive, f"
        "$mainMod, U, changegroupactive, b"
        "$mainMod, I, layoutmsg, cyclenext loop"
        "$mainMod, U, layoutmsg, cycleprev loop"
        "$mainMod, B, exec, brave"
        "$mainMod, return, exec, $terminal"
        "$mainMod, N, exec, kitty -e nvim"
        "$mainMod, X, exec, hyprlock"
        "$mainMod, R, submap, resize"
        "$mainMod, SPACE, exec, hyprctl switchxkblayout current next"
        "$mainMod, F, fullscreen"

# Move focus
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, J, movefocus, u"
        "$mainMod, K, movefocus, d"

# Move windows
        "SUPER_SHIFT, H, movewindow, l"
        "SUPER_SHIFT, L, movewindow, r"
        "SUPER_SHIFT, J, movewindow, u"
        "SUPER_SHIFT, K, movewindow, d"

# Workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"

# Move active window to workspace
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

# Scratchpad
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

# Scroll through workspaces
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        ];

    bindm = [
      "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
    ];

    bindel = [
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
    ];
  };

  wayland.windowManager.hyprland.extraConfig = ''
    submap = resize

    binde = , H, resizeactive, -20 0
    binde = , L, resizeactive, 20 0
    binde = , K, resizeactive, 0 -20
    binde = , J, resizeactive, 0 20
    bind = , T, layoutmsg, splitratio exact 0.333333

    bind = , Return, submap, reset
    bind = , Escape, submap, reset
    bind = , catchall, submap, reset

    submap = reset
    '';

  services.hyprpaper = {
    enable = true;

    settings = {
      preload = [
        "/home/norker/Pictures/wallpapers/NixOs.png"
      ];

      wallpaper = [
        ",/home/norker/Pictures/wallpapers/NixOs.png"
      ];
    };
  };
                     }
