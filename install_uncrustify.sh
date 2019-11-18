#!/bin/zsh

# exit when any command fails
set -e

log_i() {
  echo -e "\e[33m${1}\e[0m"
}

log_s() {
  echo -e "\e[32m${1}\e[0m"
}

check_and_install_brew() {
  if test ! $(which brew); then
    log_i "Installing Homebrew..."
    mkdir  ~/.brew && cd ~/.brew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 && cd -
  fi
}

prepare_brew () {
	sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/sbin
	chmod u+w /usr/local/bin /usr/local/lib /usr/local/sbin
}

#filename of the app
filename="FB XC Extensions"

# check and install brewf
check_and_install_brew

# prepare brew (optional, will be reset by the tools scripts)
prepare_brew

# delete old formula
log_i "Removing existing Uncrustify formula"
brew formula samish_uncrustify | xargs rm -rf

# brew install samish_uncrustify
log_i "Installing Uncrustify"
brew reinstall -f https://raw.githubusercontent.com/samishchandra/homebrew/master/Formula/samish_uncrustify.rb

# download config file
log_i "Updating Uncrustify config file"
curl -fSL https://raw.githubusercontent.com/samishchandra/homebrew/master/archive/uncrustify/uncrustify.cfg -o $HOME/uncrustify.cfg

# download Xcode extension
log_i "Downloading Xcode extension"
curl -fsSL https://www.dropbox.com/s/jfxiugx3v578rz5/FB%20XC%20Extensions.zip -o "${filename}.zip"

# unzip Xcode extension
log_i "Unzipping Xcode extension"
unzip "${filename}.zip"

# Move app to applications folder and open
log_i "Copying Xcode extension to Applications folder"
cp -Rf "${filename}/${filename}.app" /Applications/
open "/Applications/${filename}.app"

# update to latest config file if needed
log_i "Updating config file for Xcode Extensions"
extension_app_folder_path=$HOME/Library/Containers/FB.FB-XC-Extensions-Host.FB-Uncrustify/Data
if [ -d $app_folder_path/uncrustify ]; then
  curl -fSL https://raw.githubusercontent.com/samishchandra/homebrew/master/archive/uncrustify/uncrustify.cfg -o $extension_app_folder_path/uncrustify/uncrustify.cfg
fi

# cleanup
log_i "Cleanup"
rm -rf "${filename}"
rm -rf "${filename}.zip"
rm -rf "${filename}.app"
rm -rf "__MACOSX"

log_s "Successfully Upgraded!"
