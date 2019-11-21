#!/bin/zsh

# exit when any command fails
set -e

log_i() {
  echo -e "\e[33m${1}\e[0m"
}

log_s() {
  echo -e "\e[32m${1}\e[0m"
}

# filename of the extensions host app
filename="FB XC Extensions"

# download Xcode extension
log_i "Downloading Xcode extension"
curl -fsSL https://www.dropbox.com/s/jfxiugx3v578rz5/FB%20XC%20Extensions.zip -o "$filename.zip"

# unzip Xcode extension
log_i "Unzipping Xcode extension"
unzip "$filename.zip"

# move app to applications folder and open
log_i "Copying Xcode extension to Applications folder"
cp -Rf "$filename/$filename.app" /Applications/
open "/Applications/$filename.app"

# update to latest config file if needed
log_i "Updating config file for Xcode Extensions"
extension_app_folder_path=$HOME/Library/Containers/FB.FB-XC-Extensions-Host.FB-Uncrustify/Data
if [ -d $app_folder_path/uncrustify ]; then
  curl -fSL https://raw.githubusercontent.com/samishchandra/homebrew/master/archive/uncrustify/uncrustify.cfg -o $extension_app_folder_path/uncrustify/uncrustify.cfg
fi

# cleanup files
log_i "Cleanup"
rm -rf "$filename"
rm -rf "$filename.zip"
rm -rf "$filename.app"
rm -rf "__MACOSX"

log_s "Successfully Updated Xcode Extensions !!"
