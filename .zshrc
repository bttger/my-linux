
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-.]=** r:|=**'
zstyle ':completion:*' max-errors 2 numeric
zstyle :compinstall filename '/home/tom/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=10000
setopt autocd
bindkey -e
# End of lines configured by zsh-newuser-install

# If the internal history needs to be trimmed to add the current command line, setting this
# option will cause the oldest history event that has a duplicate to be lost before losing a
# unique event from the list. You should be sure to set the value of HISTSIZE to a larger
# number than SAVEHIST in order to give you some room for the duplicated events, otherwise
# this option will behave just like HIST_IGNORE_ALL_DUPS once the history fills up with unique
# events.
setopt HIST_EXPIRE_DUPS_FIRST
# When searching for history entries in the line editor, do not display duplicates of a line
# previously found, even if the duplicates are not contiguous.
setopt HIST_FIND_NO_DUPS
# If a new command line being added to the history list duplicates an older one, the older
# command is removed from the list (even if it is not the previous event).
setopt HIST_IGNORE_ALL_DUPS
# Do not enter command lines into the history list if they are duplicates of the previous event.
setopt HIST_IGNORE_DUPS
# Remove command lines from the history list when the first character on the line is a space,
# or when one of the expanded aliases contains a leading space. Only normal aliases (not
# global or suffix aliases) have this behaviour. Note that the command lingers in the internal
# history until the next command is entered before it vanishes, allowing you to briefly reuse
# or edit the line. If you want to make it vanish right away without entering another command,
# type a space and press return.
setopt HIST_IGNORE_SPACE
# When writing out the history file, older commands that duplicate newer ones are omitted.
setopt HIST_SAVE_NO_DUPS
# This option works like APPEND_HISTORY except that new history lines are added to the $HISTFILE
# incrementally (as soon as they are entered), rather than waiting until the shell exits.
setopt INC_APPEND_HISTORY

# Customizing the prompt
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
PROMPT="%B%F{magenta}[%n:%f%F{blue}%(4~|../|)%3~%f%F{magenta}]%f%b "
RPROMPT="%B%F{red}%(0?||Exit code: %?)%f%b"


source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# Must go last (see https://github.com/zsh-users/zsh-syntax-highlighting#why-must-zsh-syntax-highlightingzsh-be-sourced-at-the-end-of-the-zshrc-file)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
