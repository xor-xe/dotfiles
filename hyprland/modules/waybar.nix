{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = ["hyprland/workspaces" "hyprland/window"];
        modules-center = ["clock"];
        modules-right = ["pulseaudio" "backlight" "network" "cpu" "power-profiles-daemon" "memory" "battery" "tray" "hyprland/language"];

        # Language module configuration
        "hyprland/language" = {
          format = ''🌐 {}'';  # Icon followed by layout code
          format-en = "ინგ";    # Custom name for English layout
          format-ka = "ქარ";    # Custom name for georhian layout
          # Add more formats for other layouts as needed
          tooltip = true;      # Show full layout name on hover
          on-click = "hyprctl switchxkblayout next"; # Cycle layouts on click
          # keyboard-name = "your-keyboard-device"; # Uncomment and specify if needed
        };

        "power-profiles-daemon" = {
        format = "{icon}";  # Shows icon only (compact); or "{icon} {profile}" for name too
        tooltip-format = "Power profile: {profile}";  # Tooltip with details
        tooltip = true;
        format-icons = {
          "default" = "󰋄";      # Nerd Font icon for default (customize as needed)
          "performance" = "დატვირთვა";  # High perf
          "balanced" = "ბალანსი";     # Balanced
          "power-saver" = "მოშვება";  # Power saver
        };
        # Optional: on-click-left = "powerprofilesctl launch -p balanced";  # Custom action instead of default cycle
      };

        # Other module configurations (example)
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            default = "";
            focused = "";
          };
        };
        clock = {
          format = '' {:%I:%M %p}'';  # Clock icon + 12-hour time
          tooltip-format = ''{:%A, %B %d, %Y} at {:%I:%M %p}'';
        };
        battery = {
          format = ''{icon} {capacity}%'';
          format-icons = ["" "" "" "" ""];
        };
        pulseaudio = {
          format = ''{icon} {volume}%'';
          format-icons = {
            default = ["🔈" "🔉" "🔊"];
            muted = "🔇";
          };
        };
        # Backlight module configuration
        backlight = {
          device = "amdgpu_bl1"; # Adjust if needed. Check with `brightnessctl --list` :cite[1]
          format = "{icon} {percent}%";
          format-icons = ["🌑" "🌘" "🌗" "🌖" "🌕"]; # Custom icons for different brightness levels
          # Optional: Specify min-brightness if needed (default is 0) :cite[8]
          min-brightness = 15;
        };
        cpu = {
          format = " {usage}%"; # Using Nerd Font icon
          interval = 5;
          tooltip = true;
        };
        
        # Memory module configuration  
        memory = {
          format = " {used:0.1f}G/{total:0.1f}G"; # Using Nerd Font icon
          interval = 5;
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 8px;
        font-family: "FiraCode Nerd Font", "Font Awesome 6 Free";
        font-size: 12px;
        min-height: 0;
      }

      window#waybar {
        background-color: rgba(40, 44, 52, 0.9);
        color: #abb2bf;
        transition: background-color 0.2s;
        margin: 5px;
      }

      #workspaces {
        background-color: rgba(97, 175, 239, 0.3);
        padding: 0 5px;
        margin: 2px;
      }

      #workspaces button {
        color: #abb2bf;
        padding: 0 5px;
      }

      #workspaces button.active {
        color: #61afef;
      }

      #workspaces button:hover {
        background: rgba(97, 175, 239, 0.2);
      }

      #language {
        background-color: rgba(152, 195, 121, 0.3);
        color: #98c379;
        padding: 0 10px;
        margin: 2px;
      }

      #clock {
        background-color: rgba(86, 182, 194, 0.3);
        color: #56b6c2;
        padding: 0 10px;
        margin: 2px;
      }

      #battery {
        background-color: rgba(97, 175, 239, 0.3);
        color: #61afef;
        padding: 0 10px;
        margin: 2px;
      }

      #battery.warning {
        color: #e5c07b;
      }

      #battery.critical {
        color: #e06c75;
      }

      #pulseaudio {
        background-color: rgba(224, 108, 117, 0.3);
        color: #e06c75;
        padding: 0 10px;
        margin: 2px;
      }

      #network {
        background-color: rgba(171, 178, 191, 0.3);
        color: #abb2bf;
        padding: 0 10px;
        margin: 2px;
      }

      #tray {
        background-color: rgba(40, 44, 52, 0.6);
        padding: 0 10px;
        margin: 2px;
      }

      #cpu, #memory {
        background-color: rgba(86, 182, 194, 0.3);
        color: #56b6c2;
        padding: 0 10px;
        margin: 2px;
        border-radius: 8px;
        font-family: "FiraCode Nerd Font";
      }

      /* CPU-specific styling */
      #cpu {
        background: linear-gradient(
          rgba(97, 175, 239, 0.3),
          rgba(97, 175, 239, 0.1)
        );
        color: #61afef;
        border-left: 2px solid #61afef;
      }

      /* Memory-specific styling */
      #memory {
        background: linear-gradient(
          rgba(152, 195, 121, 0.3),
          rgba(152, 195, 121, 0.1)
        );
        color: #98c379;
        border-left: 2px solid #98c379;
      }

       #backlight {
        background-color: rgba(229, 192, 123, 0.3); /* Softer amber/orange with transparency */
        color: #e5c07b; /* Amber text color */
        padding: 0 10px;
        margin: 2px;
        border-radius: 8px;
        font-family: "FiraCode Nerd Font";
        border-left: 2px solid #e5c07b; /* Amber accent border */
      }

      #backlight:hover {
        background-color: rgba(229, 192, 123, 0.5); /* Slightly more opaque on hover */
        transition: background-color 0.3s ease;
      }

      #power-profiles-daemon { color: #ffffff; padding: 0 10px; }
      #power-profiles-daemon.performance { color: #f53c3c; }  /* Red for perf mode */
      #power-profiles-daemon.balanced { color: #fabd2f; }     /* Yellow for balanced */
      #power-profiles-daemon.power-saver { color: #83a598; } /* Green for saver */

      /* Hover effects */
      #cpu:hover, #memory:hover {
        background-color: rgba(255, 255, 255, 0.1);
        transition: background-color 0.3s ease;
      }

      /* Critical/warning states */
      #cpu.critical, #memory.critical {
        color: #e06c75;
        animation: pulse 2s infinite;
      }

      @keyframes pulse {
        0% { opacity: 1; }
        50% { opacity: 0.5; }
        100% { opacity: 1; }
      }
    '';
  };
}