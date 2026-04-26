{
nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--older-30-days";
  };
}
