# dotfiles

用于在 Linux 服务器之间同步 zsh、Vim 和 tmux 的个人配置。仓库只保存个人配置；Oh My Zsh、zsh-autosuggestions、Vundle 和 Vim 插件由安装脚本重新下载。

## 目录结构

```text
dotfiles/
├── zsh/
│   ├── .zshrc
│   ├── .zshrc.local.example
│   └── custom/
│       └── aliases.zsh
├── vim/
│   ├── .vimrc
│   └── .vim/
│       └── bundles.vim
├── tmux/
│   └── .tmux.conf
├── .gitignore
├── install.sh
└── README.md
```

## 安装

先安装 `git`、`zsh`、`vim` 和 `tmux`，然后执行：

```bash
git clone git@github.com:Szy0127/dotfiles.git ~/dotfiles
cd ~/dotfiles
bash install.sh
```

脚本会：

1. 安装 Oh My Zsh 和 zsh-autosuggestions。
2. 链接 `.zshrc`、`.vimrc`、Vim 配置及 `.tmux.conf`。
3. 安装 Vundle 和 `bundles.vim` 中声明的 Vim 插件。
4. 将被替换的原文件保存到 `~/.dotfiles-backup/<时间戳>/`。

只建立配置链接、不访问网络：

```bash
bash install.sh --links-only
```

Vim 插件保存在 `~/.vim/bundle/`，运行时备份和交换文件保存在 `~/.vim/data/`；这些内容都不会提交到仓库。

## 本机配置

代理、Token、密码、私有路径等内容写入 `~/.zshrc.local`。`.zshrc` 会在最后自动加载它，但安装脚本不会创建或覆盖该文件。

```bash
cp ~/dotfiles/zsh/.zshrc.local.example ~/.zshrc.local
vim ~/.zshrc.local
```

不要将 `~/.zshrc.local` 加入 Git。

## 更新插件

```bash
vim +PluginUpdate +qall
git -C ~/.oh-my-zsh pull --ff-only
git -C ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions pull --ff-only
```
