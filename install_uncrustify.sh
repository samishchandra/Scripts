#!/bin/zsh

# exit when any command fails
set -e

filename="FB XC Extensions"

# delete old formula
echo "Removing existing Uncrustify formula"
brew formula samish_uncrustify | xargs rm -rf

# brew install samish_uncrustify
echo "Installing Uncrustify"
brew reinstall -f https://raw.githubusercontent.com/samishchandra/homebrew/master/Formula/samish_uncrustify.rb

# download config file
echo "Updating Uncrustify config file"
curl -fSL https://raw.githubusercontent.com/samishchandra/homebrew/master/archive/uncrustify/uncrustify.cfg -o $HOME/uncrustify.cfg

# download Xcode extension
echo "Downloading Xcode extension"
curl -fsSL https://www.dropbox.com/s/jfxiugx3v578rz5/FB%20XC%20Extensions.zip -o "${filename}.zip"

# unzip Xcode extension
echo "Unzipping Xcode extension"
unzip "${filename}.zip"

# Move app to applications folder and open
echo "Copying Xcode extension to Applications folder"
cp -Rf "${filename}/${filename}.app" /Applications/
open "/Applications/${filename}.app"

# update to latest config file if needed
echo "Updating config file for Xcode extension"
extension_app_folder_path=$HOME/Library/Containers/FB.FB-XC-Extensions-Host.FB-Uncrustify/Data
if [ -d $app_folder_path/uncrustify ]; then
  curl -fSL https://raw.githubusercontent.com/samishchandra/uncrustify/master/archive/uncrustify.cfg -o $extension_app_folder_path/uncrustify/uncrustify.cfg
fi

# cleanup
echo "Cleanup"
rm -rf "${filename}"
rm -rf "${filename}.zip"
rm -rf "${filename}.app"
