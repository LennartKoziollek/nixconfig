{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  user = config.modules.user.username;
  cfg = config.modules.programs.tmux;
in {
  options.modules.programs.tmux = {
    enable = mkEnableOption "Enable tmux";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user} = {
      home.packages = with pkgs; [tmuxifier];
      programs.tmux = {
        enable = true;
        prefix = "C-a";
        baseIndex = 1;
        mouse = true;
        keyMode = "vi";
        tmuxinator.enable = true;
        plugins = with pkgs; [
          {
            plugin = tmuxPlugins.continuum;
            extraConfig = ''
              set -g @continuum-restore 'on'
              set -g @continuum-save-interval '60' # minutes
            '';
          }
          {
            plugin = tmuxPlugins.vim-tmux-navigator;
          }
          {
            plugin = tmuxPlugins.sensible;
          }
          {
            plugin = tmuxPlugins.resurrect;
          }
          {
            plugin = inputs.tmux-sessionx.packages.${pkgs.system}.default;
            extraConfig = ''
              set -g @sessionx-zoxide-mode 'on'
            '';
          }
          {
            plugin = tmuxPlugins.tmux-thumbs;
          }
          {
            plugin = tmuxPlugins.tmux-fzf;
          }
        ];

        extraConfig = ''
          # set -g default-command "\$\{SHELL}"

          setw -g mode-keys vi

          set -g base-index 1
          setw -g pane-base-index 1
          set -g renumber-windows on

          set-option -g status-position top

          bind-key h select-pane -L
          bind-key j select-pane -D
          bind-key k select-pane -U
          bind-key l select-pane -R

          bind '"' split-window -c "#{pane_current_path}"
          bind % split-window -h -c "#{pane_current_path}"
          bind c new-window -c "#{pane_current_path}"

          bind-key -n C-S-Left swap-window -t -1
          bind-key -n C-S-Right swap-window -t +1


          # --- Status line ---
          set-option -g status-left ""
          set-option -g status-right "[#S]"

          setw -g window-status-format ' #I-#W '
          setw -g window-status-current-format '[#I-#W]'

          set-option -g status-interval 1
          set-option -g automatic-rename on
          set-option -g automatic-rename-format '#{b:pane_current_path}'

          ${
            if config.modules.programs.themer.enable
            then ''source-file ~/.config/tmux/themer.conf''
            else ""
          }
        '';
      };
    };
  };
}
