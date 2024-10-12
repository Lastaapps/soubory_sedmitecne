
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# Options to fzf command

FZF_EXCLUDE_DIRS=(
    ".git" ".venv"
)
for DIR in ${FZF_EXCLUDE_DIRS}; do
    FZF_EXCLUDE="${FZF_EXCLUDE} --exclude \"${DIR}\""
done

export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="fd --hidden --follow $FZF_EXCLUDE"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow $FZF_EXCLUDE"
export FZF_COMPLETION_OPTS='--border --info=inline'

# - The first argument to the function ($1) is the base path to start traversal
_fzf_compgen_path() {
  # fd --hidden --follow $FZF_EXCLUDE . "$1"
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  # fd --type d --hidden --follow $FZF_EXCLUDE . "$1"
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

