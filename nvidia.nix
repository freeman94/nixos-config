{ pkgs, lib, config, ... }:

{
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    forceFullCompositionPipeline = true;
    powerManagement = {
      enable = true;    
#      finegrained = true;
    };
  };

  services.xserver.videoDrivers = ["nvidia"];
}
