# save this as shell.nix or default.nix
{ pkgs ? import <nixpkgs> {} }: 

pkgs.mkShell {
  packages = with pkgs; [
    sl
    python311
  ] ++ (with python311Packages; [
    tensorflow
    tensorboard
  ]);
}
