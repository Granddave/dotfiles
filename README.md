# dotfiles

This is my personal dotfiles repository.

[Stow](https://www.gnu.org/software/stow) is used to install symlinks to the dotfiles.

Some of the main tools that I use in my daily workflow:

- Terminal emulator: [Ghostty](https://ghostty.org)
- Terminal multiplexer: [Tmux](https://github.com/tmux/tmux)
- File editor: [Neovim](https://neovim.io)
- Shell: [Fish](https://fishshell.com/)
- Tool manager: [Mise-en-place](https://mise.jdx.dev/), [Nix](https://nixos.org/)
- Git TUI: [Tig](https://github.com/jonas/tig)
- File browser: [lf](https://github.com/gokcehan/lf)

![Screenshot](screenshot.png)


## Installation (not maintained)

**NOTE: Please *READ* and *UNDERSTAND* what the script and playbook does before executing**

```bash
$ ./bootstrap.sh
$ ansible-playbook setup.yml -K
```


## Other fun stuff

- Monospace font: [Jetbrains Mono](https://www.jetbrains.com/lp/mono/) or [Hack](https://github.com/source-foundry/Hack)
- Color scheme: [Gruvbox](https://github.com/morhetz/gruvbox)
- Background color: `#1d2021`: ![#1d2021](https://dummyimage.com/15x15/1d2021/fff.png&text=+)

Custom [Vimium](https://chrome.google.com/webstore/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb) mappings for Chrome

```vim
unmap <a-p>
map <a-n> nextTab
map <a-p> previousTab
```
