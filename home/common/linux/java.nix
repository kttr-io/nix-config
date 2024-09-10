{ inputs
, outputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.home.common.linux.java;

  jdks = [
    pkgs.temurin-bin-8
    pkgs.temurin-bin-11
    pkgs.temurin-bin-17
    pkgs.temurin-bin-21
  ];

  defaultJdk = pkgs.temurin-bin-21;
  allJdks = pkgs.lib.genAttrs jdks;
  jdkName = jdk: "${jdk.pname}-${lib.versions.major jdk.version}";
  jdkHome = jdk: ".jdks/${jdkName jdk}";
in
{
  options.home.common.linux.java = {
    enable = lib.mkEnableOption "Java module";
  };

  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
      (maven.override { jdk = defaultJdk; } )
    ];

    # Install multiple JDKs to .jdks 
    home.file = (builtins.listToAttrs (builtins.map (jdk: 
    {
      name = jdkHome jdk;
      value = { source = jdk; };
    }) jdks));

    # but there can only be one default
    programs.java = {
      enable = true;
      package = defaultJdk;
    };

    home.shellAliases = (builtins.listToAttrs (builtins.map (jdk: 
    {
      name = "jdk-${jdkName jdk}";
      value = ''
        echo 'Spawning a shell with JDK: ${jdkName jdk} ...'; 
        env JAVA_HOME=$HOME/${jdkHome jdk} PATH=${jdkHome jdk}/bin:$PATH $SHELL; 
        echo 'You are now using the default JDK (${jdkName defaultJdk}) again'
      '';
    }) jdks));
  };
}
