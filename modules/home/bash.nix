{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    
    # Bash aliases
    shellAliases = {
      ll = "ls -lah";
      la = "ls -A";
      l = "ls -CF";
      ".." = "cd ..";
      "..." = "cd ../..";
      grep = "grep --color=auto";
      df = "df -h";
      du = "du -h";
      nv = "nvim";
      
      # Git shortcuts
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline --graph --decorate";
      gd = "git diff";
      
    };
    
    # Bash initialization
    initExtra = ''
      # Git prompt function
      GIT_BRANCH_ICON=""
      GIT_STAGED_ICON=""
      GIT_UNSTAGED_ICON="✚"
      GIT_UNTRACKED_ICON="…"
      GIT_AHEAD_ICON=""
      GIT_BEHIND_ICON=""
      GIT_CLEAN_ICON=""
      
      git_prompt() {
        if git rev-parse --is-inside-work-tree &>/dev/null; then
          local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
          local staged="" unstaged="" untracked="" ahead="" behind=""
          [[ -n $(git diff --cached --quiet 2>/dev/null || echo x) ]] && staged=$GIT_STAGED_ICON
          [[ -n $(git diff --quiet 2>/dev/null || echo x) ]] && unstaged=$GIT_UNSTAGED_ICON
          [[ -n $(git ls-files --others --exclude-standard 2>/dev/null) ]] && untracked=$GIT_UNTRACKED_ICON
          local upstream=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)
          if [[ -n $upstream ]]; then
            local counts=$(git rev-list --left-right --count $upstream...HEAD 2>/dev/null)
            local behind_count=$(echo $counts | awk '{print $1}')
            local ahead_count=$(echo $counts | awk '{print $2}')
            [[ $ahead_count -gt 0 ]] && ahead="$GIT_AHEAD_ICON$ahead_count"
            [[ $behind_count -gt 0 ]] && behind="$GIT_BEHIND_ICON$behind_count"
          fi
          local clean=""
          if [[ -z $staged && -z $unstaged && -z $untracked ]]; then
            clean=$GIT_CLEAN_ICON
          fi
          
          # FIXED: Wrap all ANSI codes in \[ \] for proper bash prompt calculation
          local output=""
          output+="\[\e[33m\]$GIT_BRANCH_ICON$branch\[\e[0m\] "
          [[ -n $staged ]] && output+="\[\e[32m\]$staged\[\e[0m\]"
          [[ -n $unstaged ]] && output+="\[\e[31m\]$unstaged\[\e[0m\]"
          [[ -n $untracked ]] && output+="\[\e[31m\]$untracked\[\e[0m\]"
          [[ -n $ahead$behind ]] && output+="\[\e[31m\]$ahead$behind\[\e[0m\]"
          [[ -n $clean ]] && output+="\[\e[33m\]$clean\[\e[0m\]"
          
          echo -n "$output"
        fi
      }
      
      # PS1 with Git info - ALL color codes wrapped in \[ \]
      export PS1='$(git_prompt)\[\e[32m\]\u@\h\[\e[0m\]:\[\e[37m\]\w\[\e[0m\] \$ '
      
      # Update terminal title and history
      PROMPT_COMMAND='history -a; history -n'
      
      # History settings
      export HISTSIZE=10000
      export HISTFILESIZE=20000
      export HISTCONTROL=ignoreboth:erasedups
      shopt -s checkwinsize
      shopt -s histappend
      
      # Enable programmable completion
      if [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
      fi
      
      # Custom functions
      mkcd() {
        mkdir -p "$1" && cd "$1"
      }

      bind '"\t":menu-complete'
      bind '"\e[Z":menu-complete-backward'
      bind '"\C-a":set-mark\C-e'
    '';
    
    # Bash environment variables
    sessionVariables = {
      EDITOR = "vim";
      VISUAL = "vim";
      PAGER = "less";
      LESS = "-R";
    };
  };
}
