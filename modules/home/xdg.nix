{ pkgs, ... }:

{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Browser
      "text/html"              = "zen.desktop";
      "x-scheme-handler/http"  = "zen.desktop";
      "x-scheme-handler/https" = "zen.desktop";

      # File manager
      "inode/directory"        = "thunar.desktop";

      # PDF
      "application/pdf"        = "org.pwmt.zathura.desktop";

      # Text / code / docs
      "text/plain"                = "nvim.desktop";
      "text/markdown"             = "nvim.desktop";
      "text/x-rst"                = "nvim.desktop";
      "text/x-python"             = "nvim.desktop";
      "text/x-shellscript"        = "nvim.desktop";
      "text/x-lua"                = "nvim.desktop";
      "text/x-csrc"               = "nvim.desktop";
      "application/json"          = "nvim.desktop";
      "application/x-nix"         = "nvim.desktop";
      "application/xml"           = "nvim.desktop";

      # Images
      "image/png"   = "feh.desktop";
      "image/jpeg"  = "feh.desktop";
      "image/gif"   = "feh.desktop";
      "image/webp"  = "feh.desktop";
      "image/svg+xml" = "feh.desktop";

      # Video
      "video/mp4"              = "mpv.desktop";
      "video/x-matroska"       = "mpv.desktop";
      "video/webm"             = "mpv.desktop";

      # Audio
      "audio/mpeg"             = "mpv.desktop";
      "audio/flac"             = "mpv.desktop";
      "audio/ogg"              = "mpv.desktop";
    };
  };

  home.packages = with pkgs; [
    feh
    mpv
  ];
}
