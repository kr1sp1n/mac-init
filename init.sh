#!/bin/bash

echo "Check if brew is installed..."

if brew -v > /dev/null; then
  echo "...brew is already installed."
else
  echo "...installing brew..." 
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew tap caskroom/cask
fi

brew_apps="./brew_apps.txt"

while read -r line
do
  app=`echo $line | cut -d \; -f 1`
  cask=`echo $line | cut -d \; -f 2`
  if [ "$cask" = "cask" ]; then
    brew cask install $app
  else
    brew install $app
  fi
done < $brew_apps

mkdir ~/.nvm
