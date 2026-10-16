let
    pins = import ./npins;
    nilla = import pins.nilla;

in
nilla.create ( { config, lib }: {
    includes = [
        ./inputs.nix

    ];

    config.shells = {
        "default" = {
            systems = ["x86_64-linux"];

            shell = {mkShell, stdenv, ...}:
                mkShell {
                    packages = [
                        # config.inputs.nilla-cli.result.packages.nilla-cli.result.${stdenv.hostPlatform.system}
                        config.inputs.nix-unit.result.packages.${stdenv.hostPlatform.system}.nix-unit
                    ];
                };
        };
    };
})

