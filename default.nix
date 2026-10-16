# This module expects `lib` to be Aux Lib
{ lib }:
let

    /*
        Get a list of all nix files contained in a folder, recursing inside subfolders.

        "Nix files" are files with file names ending with ".nix".
        Files and folders beginning with an underscore "_" are ignored.

        Type:
            include-tree :: path -> [paths]
    */
    include-tree = rootFolder:
        lib.fp.pipe [
            builtins.readDir

            (lib.attrs.mapToList (entry: entryType:
                # This is basically a switch statement
                let
                    switch = {
                        "regular" = if (!lib.strings.hasPrefix "_" entry && lib.strings.hasSuffix ".nix" entry) then rootFolder + "/${entry}" else [];
                        "directory" = if !(lib.strings.hasPrefix "_" entry) then include-tree (rootFolder + "/${entry}") else [];

                    };

                in
                    if switch ? ${entryType} then switch.${entryType} else []
                )
            )

            lib.lists.flatten


        ] rootFolder;

in
include-tree

