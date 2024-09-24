{ ... }:

{
    programs.fish = {
        enable = true;
        interactiveShellInit = ''
           set fish_greeting
           abbr -a -- x exit
           abbr -a -- g git
           abbr -a -- grep 'grep --color'
        '';
    };
}
