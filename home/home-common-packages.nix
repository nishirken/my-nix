{ pkgs }:

with pkgs; [
  xdotool
  spotify
  tdesktop
  bind
  run-scaled
  ms-sys
  (makeAutostartItem {
    name = "libinput-gestures";
    package = libinput-gestures;
  })
  fzf
  silver-searcher
  bat
  audacious
  zoom-us
  chromium
  libheif # for jpg
  jpegoptim # for jpg
  optipng # for png
  imagemagick
  jq
  openssh
  nixfmt
  jetbrains-toolbox

  #own
  templates
]
