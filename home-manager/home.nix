{ config, pkgs, ... }:

{
  home.username = "oliver";
  home.homeDirectory = "/home/oliver";

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # Hyprland packages
    pkgs.hyprpaper
    pkgs.waybar
    pkgs.wofi

    # Fonts
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })

    # File management
    pkgs.dolphin
    pkgs.unzip
    pkgs.zip

    # Other
    pkgs.zathura
    pkgs.vesktop
    pkgs.brave
    pkgs.kitty
    pkgs.keepassxc
    pkgs.texliveFull
  ];

  programs = {
      kitty = {
        enable = true;
        font = {
          name = "Firacode Nerd Font";
        };
        theme = "Catppuccin-Macchiato";
      };

      git = {
        enable = true;
        userName = "Oliver Bager (DESKTOP)";
        userEmail = "oliver.nielsen.bager@gmail.com";
        extraConfig = {
          credential.helper = "store";
          init.defaultBranch = "main";
        };
      };

      bash = {
        enable = true;
        shellAliases = {
          ls = "ls -a";
          ".." = "cd ..";
        };
      };

      waybar = {
        enable = true;
        settings = {
          mainBar = {
            layer = "top";
            output = "DP-5";
            width = 1910;
            height = 30;
            margin-top = 5;
            spacing = 5;
            reload_style_on_change = true;

            modules-left = [ "hyprland/workspaces" ];
            modules-center = [ "hyprland/window" ];
            modules-right = [ "clock" ];
            
            "clock" = {
              interval = 60;
              format = "{:%a, %d. %b  %H:%M}";
            };
          };
        };

        style = "
              * {
                font-family: 'Firacode Nerd Font';
                border: none;
                border-radius: 0;
                padding: 0;
                margin: 0;
              }

              window#waybar {
                border: 2px solid rgb(255,255,255);
                border-radius: 5px;
                background: rgb(36,39,58);
              }

              #workspaces {
                background: transparent;
                padding-left: 7;
              }

              #workspaces button {
                color: rgb(255,255,255);
              }

              #window {
                color: rgb(255,255,255);
                border: 2px solid rgb(255,255,255);
                border-radius: 5px;
                padding-left: 7;
                padding-right: 7;
              }

              #clock {
                background: transparent;
                color: rgb(255,255,255);
                padding-right: 7;
              }
          ";
      };

      wofi = {
        enable = true;
        settings = {
          gtk_dark = true;
          prompt = "Type to search";
        };
        style = "
          * {
            font-family: 'Firacode Nerd Font';
            font-size: 14px;
          }

          window {
            margin: 0px;
            padding: 10px;
            border: 2px solid rgb(255, 255, 255);
            border-radius: 5px;
            background-color: rgb(36,39,58);
          }

          #input{
            margin: 5px;
            border: none;
            margin-top: 10px;
            margin-bottom: 10px;
            background-color: transparent;
          }

          #inner-box {
            margin: 5px;
            border: none;
          }

          #outer-box {
            border: none;
            background-color: transparent;
          }

          #scroll {
            margin: 0px;
            border: none;
          }

          #text {
            margin: 5px;
            border: none;
          }

          #entry {
            border:none;
          }

          #entry:selected {
            border-radius: 5px;
            font-weight: bold;
          }
          ";
      };

      zathura = {
        enable = true;
        options = {
           default-fg = "rgba(202,211,245,1)";
           default-bg = "rgba(36,39,58,1)";

           completion-bg = "rgba(54,58,79,1)";
           completion-fg = "rgba(202,211,245,1)";
           completion-highlight-bg = "rgba(87,82,104,1)";
           completion-highlight-fg = "rgba(202,211,245,1)";
           completion-group-bg = "rgba(54,58,79,1)";
           completion-group-fg = "rgba(138,173,244,1)";

           statusbar-fg = "rgba(202,211,245,1)";
           statusbar-bg = "rgba(54,58,79,1)";

           notification-bg = "rgba(54,58,79,1)";
           notification-fg = "rgba(202,211,245,1)";
           notification-error-bg = "rgba(54,58,79,1)";
           notification-error-fg = "rgba(237,135,150,1)";
           notification-warning-bg = "rgba(54,58,79,1)";
           notification-warning-fg = "rgba(250,227,176,1)";

           inputbar-fg = "rgba(202,211,245,1)";
          inputbar-bg = "rgba(54,58,79,1)";

          recolor = "true";
          recolor-lightcolor = "rgba(36,39,58,1)";
          recolor-darkcolor = "rgba(202,211,245,1)";

          index-fg = "rgba(202,211,245,1)";
          index-bg = "rgba(36,39,58,1)";
          index-active-fg = "rgba(202,211,245,1)";
          index-active-bg = "rgba(54,58,79,1)";

          render-loading-bg = "rgba(36,39,58,1)";
          render-loading-fg = "rgba(202,211,245,1)";

          highlight-color = "rgba(87,82,104,0.5)";
          highlight-fg = "rgba(245,189,230,0.5)";
          highlight-active-color = "rgba(245,189,230,0.5)";
        };
      };
  };

  services = {
      hyprpaper = {
        enable = true;
        settings = {
          ipc = "on";
          preload = [ "~/Pictures/landscapebg.jpg" "" ];
          wallpaper = [
            "DP-5,~/Pictures/landscapebg.jpg"
          ];
        };
      };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "org.pwmnt.zathura.desktop" ];
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
