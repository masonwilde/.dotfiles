#!/usr/bin/env bash

# make sure we have pulled in and updated any submodules
git submodule init
git submodule update

# what directories should be installable by all users including the root user
base=(
    bash
    vim
    nvim
    tmux
    zsh
    p10k
    git
    claude
    opencode
    helix
    alacritty
)

# folders that should, or only need to be installed for a local user
useronly=(
)

uname_var="$(uname -s)"

# run the stow command for the passed in directory ($2) in location $1
stowit() {
    usr=$1
    app=$2

    # Dry run to find conflicts, back them up
    conflicts=$(stow -n -v -R -t "${usr}" "${app}" 2>&1 | grep "existing target" | sed 's/.*existing target //' | sed 's/ since.*//')
    for file in $conflicts; do
        target="${usr}/${file}"
        if [ -e "$target" ] && [ ! -L "$target" ]; then
            echo "Backing up $target -> ${target}.bak"
            mv "$target" "${target}.bak"
        fi
    done

    stow -v -R -t "${usr}" "${app}"
}

echo ""
echo "Stowing apps for user: ${whoami}"

# install apps available to local users and root
for app in ${base[@]}; do
    echo "$app"
    stowit "${HOME}" $app
done

# install only user space folders
for app in ${useronly[@]}; do
    if [[ ! "$(whoami)" = *"root"* ]]; then
        stowit "${HOME}" $app
    fi
done

echo ""
echo "##### ALL DONE"
