{ pkgs, secrets ? {}, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user.name = secrets.gitName or "User";
      user.email = secrets.gitEmail or "user@example.com";
      github.user = secrets.gitHub or "user";

      init.defaultBranch = "master";

      pull.rebase = false;
      push.autoSetupRemote = true;
      core.editor = "nvim";
      color.ui = true;
      credential.helper = "store";
      diff.tool = "vimdiff";
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


