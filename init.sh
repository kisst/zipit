#!/bin/bash

#######################################
#
# Build lambda zip from the python file
#
#######################################

# Global variables
package_name=$(basename "$PWD")

function check_dep {

# Check that the script exist in the folder
if [ ! -f ./"$package_name".py ]; then
  echo -e "\e[7m[Error]\e[27m File not found!, this not going to work"
  echo "I was searching for "$package_name".py"
  exit 1
fi

# Check docker installed
if ! [ -x "$(command -v docker)" ]; then
  echo -e '\e[7m[Error]\e[27m Docker is not installed.' >&2
  exit 1
fi

# Try to sudo
if [[ $EUID -ne 0 ]]; then
  echo "Non root user let's try sudo"
  sudo true || exit 1
else
  echo "Don't be a fool, don't run scripts as root"
  exit 1
fi
}

check_dep

# Make sure we have the latest amazonlinux
echo -e "\e[7m[INIT]\e[27m Pulling the latest amazonlinux docker image"
sudo docker pull amazonlinux || echo -e "\e[101m[ERROR]"

# Build that zip
echo -e "\e[7m[INIT]\e[27m Run the build script"
sudo docker run --rm -it -v "$PWD":/root amazonlinux /root/build.sh "$package_name" || echo -e "\e[101m[ERROR]"
sudo chown "$(whoami)" "$package_name".zip
