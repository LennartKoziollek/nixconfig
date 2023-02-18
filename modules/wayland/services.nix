{ config, pkgs, ... }:
{
  systemd.services = {
    seatd = {
      enable = true;
      description  = "seat management deaomon";
      script = "${pkgs.seatd}/bin/seatd -g wheel";
      serviceConfig = {
        Type = "simple";
	Restart = "always";
	RestartSec = "1";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };

  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
