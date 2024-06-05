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
  nixfmt-classic
  jetbrains-toolbox
  ffmpeg_6-full # mp4 to mp3
  anki
]
