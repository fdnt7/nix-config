{...}: {
  home.sessionVariables.SUDO_PROMPT = "[0;31;1m󱇐[0m [35;1;2m>[0;35;1m>[0;94;1m>[0m";
  programs.starship = {
    enable = true;
    enableFishIntegration = false;
    settings = {
      continuation_prompt = "";

      format = "$username$hostname$sudo$cmd_duration$status$shell$character ";
      right_format = "$nix_shell$rust$package$git_status$git_branch$directory$time";

      hostname = {
        disabled = true;
        ssh_only = false;
        format = "[($hostname)]($style)";
        style = "bold purple";
      };
      username = {
        disabled = true;
        show_always = true;
        style_user = "bold bright-purple";
        style_root = "bold red";
        format = "[$user]($style)";
      };
      status = {
        disabled = false;
        style = "bold dimmed red";
        symbol = "!";
        success_symbol = "";
        not_executable_symbol = "x";
        not_found_symbol = "?";
        sigint_symbol = "#";
        signal_symbol = "%";
        format = "[$symbol$maybe_int]($style)";
        map_symbol = true;
      };

      character = {
        format = "$symbol";
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };

      shell = {
        disabled = true;
        fish_indicator = "⋊>";
        zsh_indicator = "%_";
        xonsh_indicator = "@>";
        bash_indicator = "_";
        nu_indicator = "/>";
        powershell_indicator = ">_";
        style = "bold dimmed purple";
        format = "[$indicator]($style)";
      };

      sudo = {
        disabled = false;
        style = "bold red";
        symbol = "󰌆 ";
        format = "[$symbol]($style)";
      };

      cmd_duration = {
        disabled = false;
        min_time = 250;
        style = "dimmed yellow";
        format = "[$duration]($style) ";
      };

      time = {
        disabled = false;
        style = "dimmed white";
        format = "[$time]($style)";
        time_format = "%R";
      };

      directory = {
        style = "cyan";
        home_symbol = "⌂";
        repo_root_style = "bold cyan";
        repo_root_format = "[$read_only]($read_only_style)[$before_root_path]($before_repo_root_style)[$repo_root]($repo_root_style)[$path]($style) ";
        format = "[$read_only]($read_only_style)[$path]($style) ";
        read_only = "󰍁 ";
        read_only_style = "bold red";
        fish_style_pwd_dir_length = 1;
        truncation_length = 8;
        truncation_symbol = "";
        truncate_to_repo = true;

        substitutions = {};
      };

      git_branch = {
        symbol = "󰘬";
        format = "[$symbol $branch]($style) ";
      };

      git_status = {
        style = "dimmed cyan";
        format = "([$ahead_behind$staged$modified$untracked$renamed$deleted$conflicted$stashed]($style))";
        conflicted = "[=](bright-magenta)";
        ahead = "[⇡[$\{count}](bold white)](green)";
        behind = "[⇣[$\{count}](bold white](red)";
        diverged = "[⇡[$\{ahead_count}](regular white)⇣[$\{behind_count}](regular white)](bright-magenta)";
        untracked = "[?](bright-yellow)";
        stashed = "[\$](white)";
        modified = "[!](yellow)";
        staged = "[+[$count](bold white)](bright-cyan)";
        renamed = "[»](bright-blue)";
        deleted = "[✕](red)";
      };

      package = {
        style = "bold yellow";
        format = "[$symbol$version]($style) ";
        symbol = "󰏖 ";
      };

      rust = {
        format = "[$symbol($version)]($style) ";
        symbol = " ";
      };

      nix_shell = {
        format = "[$symbol $state($name)]($style) ";
        symbol = "";
        impure_msg = "[*](bold bright-red)";
        pure_msg = "[*](bold bright-green)";
        unknown_msg = "[?](bold yellow)";
      };
    };
  };
}
