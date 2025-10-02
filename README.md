# dotfiles
## neovim
### Windows
Create symlink from `.config/nvim` to `%appdata%/Local/nvim`
```pwsh
mklink /D "%APPDATA%/nvim" "./.config/nvim"
```
