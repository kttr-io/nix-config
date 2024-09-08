{ inputs
, lib
, config
, pkgs
, ...
}:
{
  config = {
    xdg.configFile."waybar/theme.css".text = ''
      @define-color background #2e3440;
      @define-color text #eceff4;
      @define-color urgent #ebcb8b;
      @define-color warning #d08770;
      @define-color error #bf616a;
    '';
  };
}
