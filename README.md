# Dotfiles
~/ is where the <3 is

Most package manages have chezmoi in their repos already but for those that don't, see below.

## Quick Install

To quickly intall chezmoi, run:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```

To leave no trace of the install, run:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --one-shot $GITHUB_USERNAME
```
