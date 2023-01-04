#
#Local: ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u:\w]\$ '
#Java GUI
export _JAVA_AWT_WM_NONREPARENTING=1 

pfetch
