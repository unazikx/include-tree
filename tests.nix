let
    pins = import ./npins;
    aux-lib = import pins.aux-lib;

    include-tree = import ./default.nix {lib = aux-lib;};

in {
    # Check the output on a folder tree with a mix of subfolders
    testMixed0 = {
        expr = include-tree ./test/mixed;
        expected = [
            (/. + ./test/mixed/deep-nest/a/b/c/d.nix)
            (/. + ./test/mixed/has-empty-file/empty.nix)
            (/. + ./test/mixed/has-underscore-file/includethis.nix)
            (/. + ./test/mixed/one/in-one.nix)
            (/. + ./test/mixed/two/two-a.nix)
            (/. + ./test/mixed/two/two-b.nix)

        ];
    };
}
