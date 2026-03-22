{ config, ... }:
let C = config.lib.stylix.colors; in
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$git_branch$git_status$username$hostname$directory$character";

      username = {
        format = "[$user](bold #${C.base0B})";
        show_always = true;
      };

      hostname = {
        ssh_only = false;
        format = "[@$hostname](bold #${C.base0B}):";
        disabled = false;
      };

      directory = {
        format = "[$path](#${C.base0D}) ";
        truncation_length = 3;
        truncate_to_repo = false;
      };

      git_branch = {
        format = "[ $branch](#${C.base0A}):";
        symbol = " ";
      };

      git_status = {
        format = "([$all_status$ahead_behind](#${C.base08}) )";
        staged = "●";
        modified = "✎";
        untracked = "?";
        deleted = "✖";
        renamed = "»";
        stashed = "";
        ahead = "⇡$count";
        behind = "⇣$count";
        diverged = "⇡$ahead_count⇣$behind_count";
        up_to_date = "✔";
        conflicted = "✖";
      };

      character = {
        success_symbol = "[❯](#${C.base0B})";
        error_symbol = "[❯](#${C.base08})";
      };

      # disable everything else
      cmd_duration.disabled = false;
      python.disabled = false;
      nodejs.disabled = true;
      rust.disabled = true;
      package.disabled = true;
    };
  };
}
