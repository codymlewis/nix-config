{ ... }:

{
    programs.mpv = {
        enable = true;
        config = {
            profile = "gpu-hq";
            hwdec = "auto";
        };
    };
}
