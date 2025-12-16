{
  programs.git = {
    enable = true;

    settings = {
      user.name = "PatHarrison";
      user.email = "patrickgharrison@outlook.com";
      github.user = "PatHarrison";

      init.defaultBranch = "master";

      pull.rebase = false;
      core.editor = "nvim";

      color.ui = true;

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


