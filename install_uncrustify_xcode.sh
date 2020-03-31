#!/bin/zsh

# exit when any command fails
set -e

log_i() {
  echo -e $"\e[33m${1}\e[0m"
}

log_s() {
  echo -e $"\e[32m${1}\e[0m"
}

# filename of the extensions host app
filename="FB XC Extensions"

# download Xcode extension
log_i "Downloading Xcode extension"
curl -fsSL https://github.com/samishchandra/apps/blob/master/FB%20XC%20Extensions/FB%20XC%20Extensions.zip?raw=true -o "$filename.zip"

# unzip Xcode extension
log_i "Unzipping Xcode extension"
unzip "$filename.zip"

# delete old extension
log_i "Deleting existing Xcode extension"
rm -rf "/Applications/FB XC Extensions.app"
rm -rf "$HOME/Library/Containers/FB.FB-XC-Extensions-Host"
rm -rf "$HOME/Library/Containers/FB.FB-XC-Extensions-Host.FB-Uncrustify"
rm -rf "$HOME/Library/Containers/FB.FB-XC-Extensions-Host.FB-ClangFormat"
rm -rf "$HOME/Library/Containers/FB.FB-XC-Extensions-Host.FB-Utils"
rm -rf "$HOME/Library/Application Scripts/FB.FB-XC-Extensions-Host"
rm -rf "$HOME/Library/Application Scripts/FB.FB-XC-Extensions-Host.FB-Uncrustify"
rm -rf "$HOME/Library/Application Scripts/FB.FB-XC-Extensions-Host.FB-ClangFormat"
rm -rf "$HOME/Library/Application Scripts/FB.FB-XC-Extensions-Host.FB-Utils"

# move app to applications folder and open
log_i "Copying Xcode extension to Applications folder"
cp -Rf "$filename/$filename.app" /Applications/
open "/Applications/$filename.app"

# # update to latest config file if needed
# log_i "Updating config file for Xcode Extensions"
# extension_app_folder_path=$HOME/Library/Containers/FB.FB-XC-Extensions-Host.FB-Uncrustify/Data
# if [ -d $app_folder_path/uncrustify ]; then
#   curl -fSL https://raw.githubusercontent.com/samishchandra/homebrew/master/archive/uncrustify/uncrustify.cfg -o $extension_app_folder_path/uncrustify/uncrustify.cfg
# fi

# update to latest config file if needed
log_i "Updating script files for Xcode Extensions"
extension_scripts_dir="$HOME/Library/Application Scripts/FB.FB-XC-Extensions-Host.FB-Uncrustify"
mkdir -p $extension_scripts_dir
if [ -d $extension_scripts_dir ]; then
  curl -fSL https://raw.githubusercontent.com/samishchandra/apps/master/FB%20XC%20Extensions/FBXCExtensions.scpt -o $extension_scripts_dir/FBXCExtensions.scpt
fi

# cleanup files
log_i "Cleanup files"
rm -rf "$filename"
rm -rf "$filename.zip"
rm -rf "$filename.app"
rm -rf "__MACOSX"

log_s "Successfully Updated Xcode Extensions !!"
