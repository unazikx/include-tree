> [!IMPORTANT]
> THIS IS FORK FROM https://codeberg.org/scumlick/include-tree

# include-tree

Create a list of all Nix files in a folder tree, recursively searching inside subfolders.

Files and folders whose names begin with an underscore "_" are ignored.

`include-tree` is inspired by, and is designed as an alternative to, [import-tree](https://github.com/vic/import-tree).

Differences between `include-tree` and `import-tree` include:

- `include-tree` is much simpler than `import-tree` with less features.
- `include-tree` is built with [Aux Lib](https://git.auxolotl.org/auxolotl/lib) and is designed to work with projects that use Aux Lib. Projects that do not use Aux Lib should probably use `import-tree` instead.
- `include-tree` does not use flakes (and instead is built with [Nilla](https://github.com/nilla-nix/nilla)).

`include-tree` is well-suited for use in a [Nilla](https://github.com/nilla-nix/nilla) project that also uses the [dendritic pattern](https://dendrix.oeiuwq.com/Dendritic.html).

## Usage

For example, in a Nilla project that uses `npins`:

```nix
# nilla.nix
let
    pins = import ./npins;
    nilla = import pins.nilla;

    import-tree = import pins.include-tree;
in
nilla.create(
    includes = [
      # Other includes here...
    ] ++
    import-tree {inherit lib;} ./modules; # Import all nix files within the folder at path `./modules`
)
```

## Testing

Unit tests use `nix-unit`. Run all tests with:

```shell
nix-unit tests.nix
```

## License

Copyright (C) 2026 scumlick

This program (include-tree) is licensed under the GNU General Public License v3.
