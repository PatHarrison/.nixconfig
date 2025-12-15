{ pkgs, ... }:
{
  gtk = {
    enable = true;
    
    iconTheme = {
      name = "Gruvbox-Plus-Dark";
      package = pkgs.gruvbox-plus-icons;
    };
    
    gtk3.extraConfig = {
      gtk-icon-theme-name = "Gruvbox-Plus-Dark";
    };
    
    gtk4.extraConfig = {
      gtk-icon-theme-name = "Gruvbox-Plus-Dark";
    };

    # theme = {
    #   name = "adw-gtk3";
    #   package = pkgs.adw-gtk3;
    # };
  };
}
