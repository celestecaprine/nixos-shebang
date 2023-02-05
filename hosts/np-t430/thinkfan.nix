#{config, lib, pkgs, ...}:
{
  # Modprobe configuration for Thinkfan
  boot.extraModprobeConfig = ''
    options thinkpad_acpi fan_control=1
  '';
  # Thinkfan Configuration
  services.thinkfan = {
    enable = true;
    fans = [
      {
        type = "tpacpi";
        query = "/proc/acpi/ibm/fan";
      }
    ];
    sensors = [
      {
        type = "hwmon";
        query = "/sys/devices/platform/coretemp.0/hwmon";
        indices = [1 2 3 4 5];
      }
    ];
    levels = [
      [0 0 45]
      [1 40 50]
      [2 45 55]
      [3 50 60]
      [4 55 65]
      [5 60 70]
      [6 65 75]
      [7 70 80]
      ["level full-speed" 75 255]
    ];
  };
}
