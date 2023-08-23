{
  pkgs,
  config,
  ...
}: let
  username = config.modules.user.username;
in {
  # here you can add packages specific to your setup.
  environment.systemPackages = with pkgs; [
    rofi

    pdfmixtool
    imagemagick
    rnote
    evince
    spotify
    discord
    pcmanfm

    p7zip
    tshark

    xemu
    rpcs3
  ];

  home-manager.users.${username} = {
    home.packages = with pkgs; [
    ];
  };
}
