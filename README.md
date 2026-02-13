# Dotfiles

> ~/ is where the <3 is

Most package manages have chezmoi in their repos already but for those that don't, see below.

## Quick Install

To quickly intall chezmoi, run:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply raycadle
```

To leave no trace of the install, run:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --one-shot raycadle
```
