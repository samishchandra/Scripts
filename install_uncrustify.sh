#!/bin/zsh

# exit when any command fails
set -e

log_i() {
  echo -e $"\e[33m${1}\e[0m"
}

log_s() {
  echo -e $"\e[32m${1}\e[0m"
}

check_and_install_brew() {
  if test ! $(which brew); then
    log_i "Installing Homebrew..."
    mkdir  ~/.brew && cd ~/.brew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 && cd -;
  fi
}

prepare_brew () {
	sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/sbin
	chmod u+w /usr/local/bin /usr/local/lib /usr/local/sbin
}

# check and install brewf
check_and_install_brew

# prepare brew (optional, will be reset by the tools scripts)
prepare_brew

# force link
# brew link --overwrite samish_uncrustify

# delete old formula
log_i "Removing existing Uncrustify formula"
(brew formula samish_uncrustify | xargs rm -rf) 2> /dev/null

# brew install samish_uncrustify
log_i "Installing Uncrustify"
brew reinstall -f https://raw.githubusercontent.com/samishchandra/homebrew/master/Formula/samish_uncrustify.rb

# update config file
# log_i "Updating Uncrustify config file"
# curl -fSL https://raw.githubusercontent.com/samishchandra/homebrew/master/archive/uncrustify/uncrustify.cfg -o $HOME/uncrustify.cfg

log_s "Successfully Updated Uncrustify !!"
