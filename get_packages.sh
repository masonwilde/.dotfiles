#!/bin/bash

package_install=""
uname_var=$(uname -s)
if [[ $uname_var =~ "Ubuntu" ]]; then
    echo "Ubuntu"
    package_install="apt-get install"
elif [[ $uname_var =~ "Arch" ]]; then
    echo "Arch"
    package_install="pacman -S"
elif [[ $uname_var =~ "Darwin" ]]; then
    echo "Mac"
    package_install="brew install"
fi
