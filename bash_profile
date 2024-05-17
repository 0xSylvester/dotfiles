#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -f ~/.local/lib/py-libs/bin/activate ]] && . ~/.local/lib/py-libs/bin/activate
[[ -d $HOME/scripts ]] && export PATH="$PATH:$HOME/scripts"
[[ -d $HOME/.local/bin/ ]] && export PATH="$PATH:$HOME/.local/bin"
[[ -d $HOME/go/bin/ ]] && export PATH="$PATH:$HOME/go/bin"
[[ -d $HOME/.config/loadkeys/ ]] && doas loadkeys $HOME/.config/loadkeys/loadkeysrc
