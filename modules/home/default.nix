{ lib, firefox-addons, ... }:
let
  util = import ../../util { inherit lib; };
in
{
  imports = (util.importFiles ./.);
}
