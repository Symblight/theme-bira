# Theme based on Bira theme from oh-my-zsh: https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/bira.zsh-theme
# Some code stolen from oh-my-fish clearance theme: https://github.com/bpinto/oh-my-fish/blob/master/themes/clearance/

function __user_host
  set -l content 
  if [ (id -u) = "0" ];
    echo -n (set_color --bold blue)
  else
    echo -n (set_color --bold yellow)
  end
  echo -n $USER(set_color white)@(set_color --bold blue)(hostname|cut -d . -f 1) (set color normal)
end

function __current_path
  echo -n (set_color white)':'(set_color --bold magenta)(pwd | awk -F/ '{print $NF}')(set_color normal) 
end

function _git_branch_name
  echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _git_is_dirty
  echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function __git_status
  if [ (_git_branch_name) ]
    set -l git_branch (_git_branch_name)

    if [ (_git_is_dirty) ]
      set git_info (set_color white)'('(set_color red)$git_branch"*"(set_color white)')'
    else
      set git_info (set_color white)'('(set_color red)$git_branch(set_color white)')'
    end

    echo -n (set_color --bold red)$git_info (set_color normal) 
  end
end

function fish_prompt
  echo -n (set_color --bold white)"╔ "(set_color normal)
  __user_host
  __current_path
  __git_status
  echo -e ''
  echo (set_color --bold white)"╚ "(set_color --bold blue)"\$ "(set_color normal)
end

function fish_right_prompt
  set -l st $status

  if [ $st != 0 ];
    echo (set_color red) ↵ $st(set_color normal)
  end
end
