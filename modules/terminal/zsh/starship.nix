{
  config,
  inputs,
  ...
}: {
  programs.starship = {
    enable = true;
    settings = {
      format = ''
        $username$hostname$directory$git_branch$git_state$git_status $cmd_duration$line_break$character
      '';

      directory = {
        style = "blue";
      };

      character = {
        success_symbol = "[❯](green)";
        error_symbol = "[❯](red)";
      };

      git_branch = {
        format = "[$branch]($style)";
        style = "light-gray";
      };

      git_status = {
        format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
        style = "cyan";
        conflicted = "​";
        untracked = "​";
        modified = "​";
        staged = "​";
        renamed = "​";
        deleted = "​";
        stashed = "≡";
      };

      git_state = {
        format = ''\([$state( $progress_current/$progress_total)]($style)\) '';
        style = "bright-black";
      };

      cmd_duration = {
        format = "[$duration]($style) ";
        style = "yellow";
      };
    };
  };
}
