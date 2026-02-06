{ lib, ... }:
rec {
  compose =
    fns: target:
    (lib.lists.foldr (
      fn: acc: target:
      fn (acc target)
    ) (x: x) fns)
      target;
  attrsToList = attrs: lib.mapAttrsToList (key: value: { inherit key value; }) attrs;
  getFiles =
    {
      directory,
      mustHaveSuffix ? null,
      mustNotHaveSuffix ? null,
    }:
    builtins.readDir directory
    |> attrsToList
    |> (builtins.filter ({ value, ... }: value == "regular"))
    |> (builtins.filter (
      { key, ... }: if mustHaveSuffix != null then lib.strings.hasSuffix mustHaveSuffix key else true
    ))
    |> (builtins.filter (
      { key, ... }:
      if mustNotHaveSuffix != null then !(lib.strings.hasSuffix mustNotHaveSuffix key) else true
    ))
    |> (builtins.map ({ key, ... }: directory + "/${key}"));
  allFilesInDir =
    suffix: directory:
    getFiles {
      inherit directory;
      mustHaveSuffix = suffix;
    };
  allFactoriesInDir =
    factoryParams: directory:
    getFiles {
      inherit directory;
      mustHaveSuffix = ".factory.nix";
    }
    |> (builtins.map (path: (import path factoryParams)));
  factoriesOrModulesInDir =
    factoryParams: directory:
    let
      factories =
        getFiles {
          inherit directory;
          mustHaveSuffix = ".factory.nix";
        }
        |> (builtins.map (path: (import path factoryParams)));
      modules = getFiles {
        inherit directory;
        mustHaveSuffix = ".nix";
        mustNotHaveSuffix = ".factory.nix";
      };
    in
    factories ++ modules;
}
