{ config, lib }:
let
    pins = import ./npins;

    unsetValue = lib.modules.when false {};

    nixpkgsInput = config.inputs.flake-compat.result.load {
        src = config.inputs.nixpkgs.src;
    };

    # Note: Run shell command `nilla show inputs` to get a list of external inputs that the Nilla project currently has loaded
    inputsSettings = {
        nixpkgs = {
            loader = "nixpkgs";
        };

        nix-unit = {
            loader = "legacy";
        };

    };

in {
    config = {
        inputs = builtins.mapAttrs (name: pinsrc: {
            src = pinsrc;
            loader = inputsSettings."${name}".loader or unsetValue;
            settings = inputsSettings."${name}".settings or unsetValue;
        }) pins;

    };
}
