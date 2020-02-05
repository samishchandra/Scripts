#!/bin/zsh

# exit when any command fails
set -e

log_i() {
  echo -e $"\e[33m${1}\e[0m"
}

log_s() {
  echo -e $"\e[32m${1}\e[0m"
}

# update Uncrustify
curl -fSL https://raw.githubusercontent.com/samishchandra/Scripts/master/install_uncrustify.sh | sh

# update Xcode extension
curl -fSL https://raw.githubusercontent.com/samishchandra/Scripts/master/install_uncrustify_xcode.sh | sh

log_s "Successfully Updated Uncrustify & Xcode Extensions !!"
