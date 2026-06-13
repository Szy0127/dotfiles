# Locale settings are applied only when the locale exists on this host.
if (( $+commands[locale] )) && locale -a 2>/dev/null | grep -qi '^en_US\.utf-\?8$'; then
  export LC_CTYPE=en_US.UTF-8
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8
fi

# Add optional toolchains without leaving dead entries in PATH.
for extra_path in /usr/local/cuda/bin /opt/riscv/bin /opt/riscv64/bin "$HOME/.cargo/bin"; do
  [[ -d "$extra_path" ]] && path=("$extra_path" $path)
done
unset extra_path
typeset -U path PATH

export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
ZSH_THEME="ys"
plugins=(git zsh-autosuggestions)

if [[ -r "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
else
  print -u2 "oh-my-zsh is not installed; run the dotfiles install.sh"
fi

bindkey -e

export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

# Keep credentials, proxies, and host-specific paths outside the repository.
[[ -r "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
