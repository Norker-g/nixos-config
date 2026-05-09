{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$terminal" = "kitty";
      "$menu" = "rofi -show drun";
      "$mainMod" = "SUPER";
    

      env = [
        "XCURSOR_THEME,Nordzy-cursors"
        "XCURSOR_SIZE,24"
      ];

      monitor = [
        "eDP-1,1920x1080@144,0x0,1.25"
        "eDP-2,1920x1080@144,0x0,1.25"
      ];

      exec-once = [
        "waybar"
        "hyprpaper"
        "hyprctl setcursor Nordzy-black-cursors 24"
      ];

      general = {
        "col.active_border" = "rgb(81a1c1)";
        "col.inactive_border" = "rgb(434c5e)";

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

        bezier = [
          "easeOutExpo, 0.16, 1, 0.3, 1"
            "softOvershot, 0.13, 0.99, 0.29, 1.08"
            "quickFade, 0.25, 0.1, 0.25, 1"
        ];

        animation = [
          "windowsIn, 1, 4, softOvershot, popin 82%"
            "windowsOut, 1, 3, easeOutExpo, popin 88%"
            "windowsMove, 1, 3, easeOutExpo"

            "workspaces, 1, 3, easeOutExpo, slide"

            "fadeIn, 1, 3, quickFade"
            "fadeOut, 1, 2, quickFade"
            "fadeSwitch, 1, 2, quickFade"
            "fadeShadow, 1, 3, quickFade"
            "fadeDim, 1, 3, quickFade"

            "border, 1, 3, easeOutExpo"
            "borderangle, 1, 8, easeOutExpo"
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
      input = {
        "kb_layout" = "us,de,ru";
        "kb_options" = "grp:alt_win_toggle";
      };
      bind = [
        "SUPER SHIFT, Q, killactive"
        "$mainMod, M, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"
        # ", PRINT, exec, XDG_CURRENT_DESKTOP=sway flameshot gui --path ~/Pictures/screenshots"
        # "SHIFT, PRINT, exec, XDG_CURRENT_DESKTOP=sway flameshot gui -c"

        "$mainMod, V, togglefloating"
        "$mainMod, D, exec, $menu"
        "$mainMod, P, pseudo"
        "$mainMod, W, layoutmsg, togglesplit"
        "$mainMod, E, togglegroup"
        "$mainMod, I, changegroupactive, f"
        "$mainMod, U, changegroupactive, b"
        "$mainMod, I, layoutmsg, cyclenext loop"
        "$mainMod, U, layoutmsg, cycleprev loop"
        "$mainMod, B, exec, brave"
        "$mainMod, Return, exec, $terminal"
        "$mainMod, N, exec, kitty -e nvim"
        "$mainMod, X, exec, hyprlock"
        "$mainMod, R, submap, resize"
        "$mainMod, F, fullscreen"

        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, J, movefocus, u"
        "$mainMod, K, movefocus, d"

        "SUPER SHIFT, H, movewindow, l"
        "SUPER SHIFT, L, movewindow, r"
        "SUPER SHIFT, J, movewindow, u"
        "SUPER SHIFT, K, movewindow, d"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"

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

        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];
    };

    extraConfig = ''
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
  };

  services.hyprpaper = {
    enable = true;

    settings = {
      preload = [
        "/home/norker/Pictures/wallpapers/NixOs.png"
      ];

      wallpaper = [
        ",contain:/home/norker/Pictures/wallpapers/NixOs.png"
      ];
    };
  };
   # change cursor
  home.pointerCursor = {
    name = "Nordzy-cursors";
    package = pkgs.nordzy-cursor-theme;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.nordic;
      name = "Nordic";
    };

    iconTheme = {
      package = pkgs.nordzy-icon-theme;
      name = "Nordzy";
    };
  };
}
