{ ... }:

{
    programs.git = {
        enable = true;
        userName = "Cody Lewis";
        userEmail = "hello@codymlewis.com";
        signing = {
            key = null;
            signByDefault = true;
        };
        extraConfig = {
            push = { autoSetupRemote = true; };
            credential.helper = { store = true; };
            init.defaultBranch = "main";
        };
    };
}
