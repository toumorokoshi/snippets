#!/bin/bash

# This is a script which sets a random wallpaper.
# Some ideas are coming from the xplanet-script located at: http://rbrusu.com/xplanet-desktop-wallpape.html

# This a script adapted from Robert Zenz's script for Ubuntu 12.10
# Written by Robert 'Bobby' Zenz (Robert.Zenz@gmx.at or bobby@bonsaimind.org) (http://www.bonsamind.org)

# SETUP: go to "startup applications" on the dash home lens. Add this script in there.

# Config-Section
# --------------
wallpaper=~/wallpapers/     # Set it to a fixed wallpaper, or to a folder to pick
                # a random one inside that
#---------------


# Global variable, please ignore this...
pickedWallpaper=GlobalyDefined

function getRandomFile() {
  cd $1

  set -- *
  length=$#
  random_num=$(( $RANDOM % ($length + 1) ))

  pickedWallpaper=${!random_num}

  pickedWallpaper=$(pwd)/$pickedWallpaper

  cd -
}

function main() {
  getRandomFile $wallpaper
  echo "$pickedWallpaper"
  gsettings set org.gnome.desktop.background picture-uri "file://$pickedWallpaper"
}

main


