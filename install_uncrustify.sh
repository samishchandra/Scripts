#!/bin/zsh

# exit when any command fails
set -e

filename="FB XC Extensions"

# delete old formula
brew formula samish_uncrustify | xargs rm -rf

# brew install samish_uncrustify
brew reinstall -f https://raw.githubusercontent.com/samishchandra/homebrew/master/Formula/samish_uncrustify.rb

# download config file
curl -fSL https://raw.githubusercontent.com/samishchandra/uncrustify/master/archive/uncrustify.cfg -o $HOME/uncrustify.cfg

# download Xcode extension
curl -fsSL https://www.dropbox.com/s/4iys375hd3wpwre/FB%20XC%20Extensions.zip -o "${filename}.zip"

# unzip Xcode extension
unzip "${filename}.zip"

# Move app to applications folder and open
cp -Rf "${filename}/${filename}.app" /Applications/
open "/Applications/${filename}.app"

# update to latest config file if needed
extension_app_folder_path=$HOME/Library/Containers/FB.FB-XC-Extensions-Host.FB-Uncrustify/Data
if [ -d $app_folder_path/uncrustify ]; then
  curl -fSL https://raw.githubusercontent.com/samishchandra/uncrustify/master/archive/uncrustify.cfg -o $extension_app_folder_path/uncrustify/uncrustify.cfg
fi

# cleanup
rm -rf "${filename}"
rm -rf "${filename}.zip"
rm -rf "${filename}.app"
