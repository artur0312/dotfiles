function copy
  xclip -sel c "$argv[1]"
end

#fish_add_path /usr/lib

if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
    starship init fish | source 
end
