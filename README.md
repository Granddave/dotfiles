# dotfiles

This is my personal dotfiles repository.

A single Ansible playbook installs and sets up all applications and uses [stow](https://www.gnu.org/software/stow/) to install symlinks to the dotfiles.


## Installation

**NOTE: Please *READ* and *UNDERSTAND* what the script and playbook does before executing**

```bash
$ ./bootstrap.sh
$ Ansible-playbook setup.yml -K
```


## Other fun stuff

Monospace font: [Hack](https://github.com/source-foundry/Hack)

Custom Vimium mappings for Chrome

```vim
unmap <a-p>
map <a-n> nextTab
map <a-p> previousTab
```
