# New Linux Host Setup

Steps to bring up a fresh Linux machine.

---

## 1. Install packages

**Debian / Ubuntu (apt):**
```bash
sudo apt update && sudo apt install -y zsh git neovim unzip lua5.4
```

---

## 2. Git

Configure global config.

```bash
cat > ~/.gitconfig << 'EOF'
[user]
    name = Michael Ho
    email = hth.michael@gmail.com
[init]
    defaultBranch = main
[core]
    editor = nvim
    autocrlf = input
[push]
    default = current
EOF
```

Install and configure SSH keys for GitHub/GitLab: `ssh-keygen -t ed25519 -C "hth.michael@gmail.com"`.

---

## 3. Setup

Symlink dot files

```bash
ln -s ~/projects/dotfiles/init.vim ~/.config/nvim/init.vim
```
