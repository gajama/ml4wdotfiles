#!/bin/bash
#    ____         __       ____               __     __
#   /  _/__  ___ / /____ _/ / / __ _____  ___/ /__ _/ /____ ___
#  _/ // _ \(_-</ __/ _ `/ / / / // / _ \/ _  / _ `/ __/ -_|_-<
# /___/_//_/___/\__/\_,_/_/_/  \_,_/ .__/\_,_/\_,_/\__/\__/___/
#                                 /_/
#

sleep 1
clear
install_platform="$(cat ~/.config/ml4w/settings/platform.sh)"
figlet -f smslant "Updates"
echo

# ------------------------------------------------------
# Confirm Start
# ------------------------------------------------------

if gum confirm "DO YOU WANT TO START THE UPDATE NOW?"; then
    echo
    echo ":: Update started."
elif [ $? -eq 130 ]; then
    exit 130
else
    echo
    echo ":: Update canceled."
    exit
fi

_isInstalled() {
    package="$1"
    case $install_platform in
        arch)
            check="$($aur_helper -Qs --color always "${package}" | grep "local" | grep "${package} ")"
            ;;
        fedora)
            check="$(dnf repoquery --quiet --installed ""${package}*"")"
            ;;
        *) ;;
    esac

    if [ -n "${check}" ]; then
        echo 0 #'0' means 'true' in Bash
        return #true
    fi
    echo 1 #'1' means 'false' in Bash
    return #false
}

# Check if platform is supported
case $install_platform in
    arch)
        aur_helper="$(cat ~/.config/ml4w/settings/aur.sh)"

        $aur_helper

        if [[ $(_isInstalled "flatpak") == "0" ]]; then
            flatpak upgrade
        fi
        ;;
    fedora)
        sudo dnf upgrade
        if [[ $(_isInstalled "flatpak") == "0" ]]; then
            flatpak upgrade
        fi
        ;;
    *)
        echo ":: ERROR - Platform not supported"
        echo "Press [ENTER] to close."
        read
        ;;
esac

notify-send "Update complete"
echo
echo ":: Update complete"
echo
echo

echo "Press [ENTER] to close."
read
