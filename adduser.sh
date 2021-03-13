#!/bin/bash

set -ex
set -u # Treat unset variables as an error
set -o pipefail # Exit if any pipe fails

if [ "$EUID" -ne 0 ]
  then echo "Please run as root or sudo"
  exit
fi

if [ $# -ne 1 ] 
then
  echo Usage: ./adduser USERNAME
  exit 1
fi

USERNAME=$1
set +x
PASSWORD=`openssl rand -base64 14`

useradd --user-group --create-home $USERNAME

echo "$USERNAME:$PASSWORD" | sudo chpasswd
