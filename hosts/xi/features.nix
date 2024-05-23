{...}: {
  imports = [
    ../../modules
    ../../presets
  ];

  config = {
    presets = {
      rices = {
        name = "onedark";
        vertical = false;
      };
    };

    modules = {
      user = {
        homeManager.enabled = true;
        username = "lk";
        repoDirectory = "/home/lk/repos/nixconfig";

        displayServerProtocol = "wayland";
        desktopEnvironment = "hyprland";

        monitors = [
          {
            name = "eDP-1";
            resolution = "2880x1800";
            refreshRate = "90";
            scale = "1.5";
            position = "0x0";
          }
          {
            name = "DP-1";
            resolution = "3440x1440";
            refreshRate = "144";
            scale = "1";
            position = "2880x0";
            vrr = true;
          }
        ];
        keymap = "us-umlaute";
        appRunner = "walker";
        browser = "firefox";
        screenshotTool = "swappy";
      };
      system = {
        nvidia = false;
        wacom = true;
        bluetooth = true;
      };

      programs = {
        # Common programs
        installCommon = {
          terminal = true;
          desktop = true;
        };

        xdg = {
          enable = true;
          createDirectories = true;
          setAssociations = true;
        };

        # Desktop
        sddm.enable = false;
        gdm.enable = false;
        kitty = {
          enable = true;
          theme = "catppuccin-macchiato";
        };
        eww.enable = false;
        waybar.enable = false;
        swww.enable = true;
        libreoffice.enable = true;
        discord = {
          enable = true;
          aarpc = false;
        };
        pipewire.enable = true;
        hyprland = {
          sens = "0.1";
          accel = "adaptive";

          hyprlock.enable = true;
        };
        ags.enable = false;

        # Terminal
        ssh.enable = true;
        greetd.enable = true;
        tmux.enable = true;
        zellij.enable = true;
        direnv.enable = true;
        zsh.enable = true;
        zoxide.enable = true;
        neovim.enable = true;
        git = {
          enable = true; # TODO: make option for username/mail
          lazygit = true;
        };
        nh.enable = true;

        # Theming
        themer = {
          enable = true;
        };

        # Gaming
        gamescope.enable = false;
        prismLauncher.enable = false;
        lutris.enable = false;
        bottles.enable = false;
        steam.enable = false;
        retroarch.enable = false;
        gamemode.enable = true;
      };
    };
  };
}
