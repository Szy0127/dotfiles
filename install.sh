#!/usr/bin/env bash

set -Eeuo pipefail

DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)-$$"
INSTALL_PLUGINS=1

if [[ "${1:-}" == "--links-only" ]]; then
  INSTALL_PLUGINS=0
elif [[ $# -gt 0 ]]; then
  printf 'Usage: %s [--links-only]\n' "$0" >&2
  exit 2
fi

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    printf 'Missing required command: %s\n' "$1" >&2
    return 1
  fi
}

backup_target() {
  local target="$1"
  local relative="${target#"$HOME"/}"
  local backup="$BACKUP_DIR/$relative"

  mkdir -p "$(dirname -- "$backup")"
  mv -- "$target" "$backup"
  printf 'Backed up %s to %s\n' "$target" "$backup"
}

link_path() {
  local source="$1"
  local target="$2"

  mkdir -p "$(dirname -- "$target")"

  if [[ -L "$target" ]] &&
     [[ "$(readlink -f -- "$target")" == "$(readlink -f -- "$source")" ]]; then
    return
  fi

  if [[ -e "$target" || -L "$target" ]]; then
    backup_target "$target"
  fi

  ln -s -- "$source" "$target"
  printf 'Linked %s -> %s\n' "$target" "$source"
}

link_tree_files() {
  local source_root="$1"
  local target_root="$2"
  local source relative

  [[ -d "$source_root" ]] || return

  while IFS= read -r -d '' source; do
    relative="${source#"$source_root"/}"
    link_path "$source" "$target_root/$relative"
  done < <(find "$source_root" -type f -print0)
}

clone_if_missing() {
  local repository="$1"
  local destination="$2"

  if [[ ! -e "$destination" ]]; then
    mkdir -p "$(dirname -- "$destination")"
    git clone --depth 1 "$repository" "$destination"
  fi
}

for command_name in zsh vim tmux; do
  require_command "$command_name"
done

if (( INSTALL_PLUGINS )); then
  require_command git
  clone_if_missing \
    https://github.com/ohmyzsh/ohmyzsh.git \
    "$HOME/.oh-my-zsh"
  clone_if_missing \
    https://github.com/zsh-users/zsh-autosuggestions.git \
    "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
fi

link_path "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
link_tree_files "$DOTFILES_DIR/zsh/custom" "$HOME/.oh-my-zsh/custom"

link_path "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"
mkdir -p "$HOME/.vim"
link_tree_files "$DOTFILES_DIR/vim/.vim" "$HOME/.vim"
mkdir -p "$HOME/.vim/data/backup" "$HOME/.vim/data/swap"

link_path "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

if (( INSTALL_PLUGINS )); then
  clone_if_missing \
    https://github.com/VundleVim/Vundle.vim.git \
    "$HOME/.vim/bundle/Vundle.vim"
  vim +PluginInstall +qall
fi

printf 'Dotfiles installed from %s\n' "$DOTFILES_DIR"
if [[ -d "$BACKUP_DIR" ]]; then
  printf 'Previous files were saved under %s\n' "$BACKUP_DIR"
fi
