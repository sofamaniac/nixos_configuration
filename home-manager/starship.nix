{lib, ...}: {
  catppuccin.starship.enable = true;
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = lib.concatStrings [
        "[](sapphire)"
        "$os"
        "$username"
        "[](fg:sapphire bg:teal)"
        "$directory"
        "[](fg:teal bg:green)"
        "$git_branch"
        "$git_status"
        "[](fg:green bg:yellow)"
        "$c"
        "$haskell"
        "$rust"
        "[](fg:yellow bg:pink)"
        "$docker_context"
        "[](fg:pink bg:red)"
        "$time"
        "[ ](fg:red)\n$character"
      ];

      # Disable the blank line at the start of the prompt
      # add_newline = false

      # You can also replace your username with a neat symbol like   or disable this
      # and use the os module below
      username = {
        show_always = true;
        style_user = "bg:sapphire fg:crust";
        style_root = "bg:sapphire fg:red";
        format = "[$user ]($style)";
        disabled = false;
      };

      # An alternative to the username module which displays a symbol that
      # represents the current operating system
      os = {
        style = "bg:sapphire fg:peach";
        disabled = false; # Disabled by default
      };

      directory = {
        style = "bg:teal fg:crust";
        format = "[ $path ]($style)";
        #truncation_length = 10;
        #truncation_symbol = "…/";
        # Here is how you can shorten some long paths by text replacement
        # similar to mapped_locations in Oh My Posh:
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
          # Keep in mind that the order matters. For example:
          # "Important Documents" = " 󰈙 "
          # will not be replaced, because "Documents" was already substituted before.
          # So either put "Important Documents" before "Documents" or use the substituted version:
          # "Important 󰈙 " = " 󰈙 "
        };
      };

      git_branch = {
        symbol = "";
        style = "bg:green fg:crust";
        format = "[ $symbol $branch ]($style)";
      };

      git_status = {
        style = "bg:green fg:crust";
        format = "[$all_status$ahead_behind ]($style)";
      };

      c = {
        symbol = " ";
        style = "bg:yellow fg:crust";
        format = "[ $symbol ($version) ]($style)";
      };

      haskell = {
        symbol = " ";
        style = "bg:yellow fg:crust";
        format = "[ $symbol ($version) ]($style)";
      };

      rust = {
        symbol = "";
        style = "bg:yellow fg:crust";
        format = "[ $symbol ($version) ]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R"; # Hour:Minute Format
        style = "bg:red fg:crust";
        format = "[ ♥ $time ]($style)";
      };
    };
  };
}
