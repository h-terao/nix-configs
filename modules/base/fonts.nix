{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "base.fonts";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    fonts = {
      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-serif
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        plemoljp
        nerd-fonts.noto
      ];
      # fontDir.enable = true;
      fontconfig = {
        enable = true;
        defaultFonts = {
          serif = [
            "Noto Serif"
            "Noto Serif CJK JP"
            "Noto Color Emoji"
          ];
          sansSerif = [
            "Noto Sans"
            "Noto Sans CJK JP"
            "Noto Color Emoji"
          ];
          monospace = [
            "PlemolJP Console"
            "Noto Color Emoji"
          ];
          emoji = [ "Noto Color Emoji" ];
        };
      };
    };
  };

  home.ifEnabled = {
    # GTK font settings
    gtk = {
      enable = true;
      font = {
        name = "Noto Sans CJK JP";
        size = 11;
      };
    };
  };
}
