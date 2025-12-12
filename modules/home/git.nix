{
  programs.git = {
    enable = true;

    userName = "PatHarrison";
    userEmail = "patrickgharrison@outlook.com";

    extraConfig = {
      guthub.user = "PatHarrison";

    init.defaultBranch = "master";

    pull.rebase = false;
    core.editor = "nvim";

    color.vi = true;

    credential.helper = "store";
    };
  };
  
  programs.gh = {
    enable = true;

    settings = {
      git_protocol = "ssh";
      editor = "nvim";
    };
  };
}


