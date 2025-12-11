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
      # Git icons
      GIT_BRANCH_ICON=""
      GIT_STAGED_ICON=""
      GIT_UNSTAGED_ICON="✚"
      GIT_UNTRACKED_ICON="…"
      GIT_AHEAD_ICON=""
      GIT_BEHIND_ICON=""
      GIT_CLEAN_ICON=""

      # Simple git prompt function
      git_prompt() {
        # Check if we're in a git repo
        git rev-parse --is-inside-work-tree &>/dev/null || return
        
        # Get current branch
        local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
        
        # Start with branch
        printf '\001\e[33m\002%s %s\001\e[0m\002 ' "$GIT_BRANCH_ICON" "$branch"
        
        # Check for staged files
        if ! git diff --cached --quiet 2>/dev/null; then
          printf '\001\e[32m\002%s\001\e[0m\002' "$GIT_STAGED_ICON"
        fi
        
        # Check for unstaged changes
        if ! git diff --quiet 2>/dev/null; then
          printf '\001\e[31m\002%s\001\e[0m\002' "$GIT_UNSTAGED_ICON"
        fi
        
        # Check for untracked files
        if [[ -n $(git ls-files --others --exclude-standard 2>/dev/null) ]]; then
          printf '\001\e[31m\002%s\001\e[0m\002' "$GIT_UNTRACKED_ICON"
        fi
        
        # Check ahead/behind remote
        local upstream=$(git rev-parse --abbrev-ref @{u} 2>/dev/null)
        if [[ -n $upstream ]]; then
          local ahead_behind=$(git rev-list --left-right --count $upstream...HEAD 2>/dev/null)
          local behind=$(echo $ahead_behind | awk '{print $1}')
          local ahead=$(echo $ahead_behind | awk '{print $2}')
          
          if [[ $ahead -gt 0 ]]; then
            printf '\001\e[35m\002%s%s\001\e[0m\002' "$GIT_AHEAD_ICON" "$ahead"
          fi
          if [[ $behind -gt 0 ]]; then
            printf '\001\e[35m\002%s%s\001\e[0m\002' "$GIT_BEHIND_ICON" "$behind"
          fi
        fi
        
        # If nothing was printed (clean), show clean icon
        if git diff --quiet 2>/dev/null && git diff --cached --quiet 2>/dev/null && [[ -z $(git ls-files --others --exclude-standard 2>/dev/null) ]]; then
          printf '\001\e[32m\002%s\001\e[0m\002' "$GIT_CLEAN_ICON"
        fi
        
        printf ' '
      }

      # Set PS1 with git info
      export PS1='$(git_prompt)\[\e[32m\]\u@\h\[\e[0m\]:\[\e[38m\]\w\[\e[0m\]\$ '
      
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
