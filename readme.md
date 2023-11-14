# Tmuxifier config

## Initial Setup
Clone this repository into `~/.config/tmux`

```bash
git clone https://github.com/sankargorthi/tmux.conf ~/.config/tmux
brew install tmux
```

## Configuration

Get [tmuxifier](https://github.com/jimeh/tmuxifier)

```bash
git clone https://github.com/jimeh/tmuxifier.git ~/.config/tmux/tmuxifier
```

and initialize it.

```bash
export PATH="$PATH:$HOME/.config/tmux/tmuxifier/bin"
```

Add the initializer script to the your shell script (`.bashrc` or `.zshrc`):

```bash
eval "$(tmuxifier init -)"
```


## Create a few sessions

Refer to the tmuxifier documentation for how to create sessions and setting up splits and windows.

```bash
tmuxifier new-session build-something
```
