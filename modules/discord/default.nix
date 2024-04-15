{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib; let
  username = config.modules.user.username;
  cfg = config.modules.programs.discord;
in {
  options.modules.programs.discord = {
    enable = mkEnableOption "Enable Discord";
    aarpc = mkEnableOption "Enable aarpc for discord rich presence";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      home-manager.users.${username} = {
        home.packages = with pkgs; [
          webcord-vencord
          armcord
          (vesktop.overrideAttrs (old: {
            src = fetchFromGitHub {
              owner = "Vencord";
              repo = "Vesktop";
              rev = "3fdc55a47e48d0bfd0bfa5cc9f9f566a57d99417";
              hash = "sha256-K6+G82yIQgi5NhYOobDYlqvPzFhPSg4NDdmPy8PHwVI=";
            };
          }))
          # (vesktop.overrideAttrs (old: {
          #   # patches = (old.patches or []) ++ [./readonlyFix.patch];
          #   postFixup = ''
          #     wrapProgram $out/bin/vesktop \
          #            wrapProgram $out/bin/vencorddesktop \
          #                   --add-flags "--ozone-platform=wayland \
          #                       --enable-zero-copy \
          #                       --use-gl=angle \
          #                       --use-vulkan \
          #                       --disable-reading-from-canvas \
          #                       --enable-oop-rasterization \
          #                       --enable-raw-draw \
          #                       --enable-gpu-rasterization \
          #                       --enable-gpu-compositing \
          #                       --enable-native-gpu-memory-buffers \
          #                       --enable-accelerated-2d-canvas \
          #                       --enable-accelerated-video-decode \
          #                       --enable-accelerated-mjpeg-decode \
          #                       --disable-gpu-vsync \
          #                       --enable-features=Vulkan,VulkanFromANGLE,DefaultANGLEVulkan,VaapiIgnoreDriverChecks,VaapiVideoDecoder,PlatformHEVCDecoderSupport"
          #   '';
          # }))
        ];
      };
    }
    (mkIf cfg.aarpc {
      home-manager.users.${username} = {
        home.packages = [
          inputs.arrpc.packages.${pkgs.system}.arrpc
        ];
      };
    })
  ]);
}
