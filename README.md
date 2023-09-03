# Dotfiles
A very minimal collection of dotfiles managed by chezmoi.

## Usage
After a fresh Linux install, run:
```shell
chezmoi init --apply --verbose https://github.com/N3WK1D/dotfiles.git
```

If chezmoi is not found in the distro's repos, run:
```shell
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply N3WK1D
```

For a one-shot install, run:
```shell
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --one-shot N3WK1D
```

## Reference
Chezmoi's user manual can be found [here](https://www.chezmoi.io/user-guide/command-overview/).
