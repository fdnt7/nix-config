{...}: {
  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })

      # temporary workaround for: https://github.com/NixOS/nixpkgs/issues/389609
      # by: https://github.com/NixOS/nixpkgs/issues/389609#issuecomment-2726424009
      (
        final: prev: {
          # https://github.com/wwmm/easyeffects/commit/38bef46bffdb535e2a70c3332719c557ff577e56
          jamesdsp = prev.jamesdsp.overrideAttrs {
            patchPhase = ''
              substituteInPlace src/audio/pipewire/PwPipelineManager.cpp \
                --replace-fail "pw_node_add_listener" "pw_proxy_add_object_listener" \
                --replace-fail "pw_link_add_listener" "pw_proxy_add_object_listener" \
                --replace-fail "pw_module_add_listener" "pw_proxy_add_object_listener" \
                --replace-fail "pw_client_add_listener" "pw_proxy_add_object_listener" \
                --replace-fail "pw_device_add_listener" "pw_proxy_add_object_listener"
            '';
          };
        }
      )
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };
}
