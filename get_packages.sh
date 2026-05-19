#!/bin/bash

package_install=""
if [[ "$(uname -s)" == "Darwin" ]]; then
    echo "Mac"
    package_install="brew install"
elif command -v pacman &>/dev/null; then
    echo "Arch"
    package_install="sudo pacman -S --needed"
elif command -v apt &>/dev/null; then
    echo "Ubuntu/Debian"
    package_install="sudo apt install -y"
fi
