set PATH "$HOME/bin:$HOME/.local/bin:/usr/local/cuda-11.0/bin:$PATH"
set EDITOR "vim"
set SMPLX_DIR ~/proj/smpl
if test ~/.aliases
   . ~/.aliases
end
function fish_greeting
    if set -q fish_private_mode
        echo "fish is running in private mode"
    end
end

# Options
#set __fish_git_prompt_show_informative_status
set __fish_git_prompt_showcolorhints
#set __fish_git_prompt_showupstream "informative"

# Colors
set green (set_color green)
set magenta (set_color magenta)
set normal (set_color normal)
set red (set_color red)
set yellow (set_color yellow)

set __fish_git_prompt_color_branch magenta --bold
set __fish_git_prompt_color_dirtystate white
set __fish_git_prompt_color_invalidstate red
set __fish_git_prompt_color_merging yellow
set __fish_git_prompt_color_stagedstate yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

function fish_prompt
    set_color $fish_color_cwd
    echo -n (prompt_pwd)
    set_color normal
    printf '%s' (__fish_git_prompt)
    set_color normal
    echo ' > '
end

status --is-interactive; and source (jump shell fish | psub)

function __jump_add --on-variable PWD
  status --is-command-substitution; and return
  jump chdir
end

function __jump_hint
  set -l term (string replace -r '^j ' '' -- (commandline -cp))
  jump hint $term
end

function j
  set -l dir (jump cd $argv)
  test -d "$dir"; and cd "$dir"
end

complete --command j --exclusive --arguments '(__jump_hint)'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/sxyu/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

