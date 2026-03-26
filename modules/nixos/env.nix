# modules/nixos/env.nix
{ ... }:

{
  environment.variables = {
    # Nvidia/Wayland
    __GL_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_DRM_NO_ATOMIC = "1";
    HYPRLAND_NO_SD_NOTIFY = "1";
    NVD_BACKEND = "direct";
    GBM_BACKEND = "nvidia-drm";
  };

  environment.sessionVariables = {
    # Steam/gaming (session-scoped)
    __NV_PRIME_RENDER_OFFLOAD = "1";
    __VK_LAYER_NV_optimus = "NVIDIA_only";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
}
