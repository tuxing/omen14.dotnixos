#special packages and services

{ pkgs, ... }:
# packages needing special arguments and services
{  environment.systemPackages = with pkgs; [ 
   pkgs.nvidia_oc
   pkgs.undervolt

 ];

#services
#nvidia_oc service
 services.udev.packages = [ pkgs.nvidia_oc ];

    systemd.services.nvidia_oc = {
      description = "Nvidia overclocking";
      documentation = [ "https://github.com/Dreaming-Codes/nvidia_oc" ];
      wantedBy = [ "graphical.target" ];
      partOf = [ "graphical.target" ];
      after = [ "graphical.target" ];

      serviceConfig = {
        Type = "dbus";
        BusName = "org.dreamingcodes.nvidia_oc";
        ExecStart = "${pkgs.nvidia_oc}/bin/nvidia_oc set --index 0 --freq-offset 150 --mem-offset 400 --min-clock 0 --max-clock 2050";
        Restart = "no";
     };
    };
 #cpu undervolt service
 services.undervolt.package = pkgs.undervolt;
 services.undervolt.enable = true;
 services.undervolt.uncoreOffset = -125;
 services.undervolt.gpuOffset = -125;
 services.undervolt.coreOffset = -125;
 services.undervolt.analogioOffset = -75;
 
}
