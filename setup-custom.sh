#!/bin/bash
clear

# Local repository
repo="$HOME/.ml4w-hyprland/dotfiles"

# Download folder

download_folder="$HOME/.ml4w"

# Functions

## Check if package is installed
_isInstalled() {
    package="$1"
    check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")"
    if [ -n "${check}" ]; then
        echo 0 #'0' means 'true' in Bash
        return #true
    fi
    echo 1 #'1' means 'false' in Bash
    return #false
}

## Check if command exists
_checkCommandExists() {
    package="$1"
    if ! command -v $package >/dev/null; then
        return 1
    else
        return 0
    fi
}

# Install required packages
_installPackages() {
    toInstall=()
    for pkg; do
        if [[ $(_isInstalled "${pkg}") == 0 ]]; then
            echo ":: ${pkg} is already installed."
            continue
        fi
        toInstall+=("${pkg}")
    done
    if [[ "${toInstall[@]}" == "" ]]; then
        # echo "All pacman packages are already installed.";
        return
    fi
    printf "Package not installed:\n%s\n" "${toInstall[@]}"
    sudo pacman --noconfirm -S "${toInstall[@]}"
}

# install yay if needed
_installYay() {
    _installPackages "base-devel"
    SCRIPT=$(realpath "$0")
    temp_path=$(dirname "$SCRIPT")
    git clone https://aur.archlinux.org/yay.git $download_folder/yay
    cd $download_folder/yay
    makepkg -si
    cd $temp_path
    echo ":: yay has been installed successfully."
}

# Required packages for the installer
packages=(
    "wget"
    "unzip"
    "gum"
    "rsync"
    "git"
)


# Some colors
GREEN='\033[0;32m'
NONE='\033[0m'

# Header
echo -e "${GREEN}"
cat <<"EOF"
   ____         __       ____
  /  _/__  ___ / /____ _/ / /__ ____
 _/ // _ \(_-</ __/ _ `/ / / -_) __/
/___/_//_/___/\__/\_,_/_/_/\__/_/

EOF
echo "ML4W Dotfiles for Hyprland"
echo -e "${NONE}"
while true; do
    read -p "DO YOU WANT TO START THE INSTALLATION NOW? (Yy/Nn): " yn
    case $yn in
        [Yy]*)
            echo ":: Installation started."
            echo
            break
            ;;
        [Nn]*)
            echo ":: Installation canceled"
            exit
            break
            ;;
        *)
            echo ":: Please answer yes or no."
            ;;
    esac
done

# Create Download folder if not exists
if [ ! -d $download_folder ]; then
    mkdir -p $download_folder
    echo ":: $download_folder folder created"
fi

# Remove existing download folder and zip files
if [ -d $download_folder/dotfiles ]; then
    rm -rf $download_folder/dotfiles
fi

# Synchronizing package databases
sudo pacman -Sy
echo

# Install required packages
echo ":: Checking that required packages are installed..."
_installPackages "${packages[@]}"

# Install yay if needed
if _checkCommandExists "yay"; then
    echo ":: yay is already installed"
else
    echo ":: The installer requires yay. yay will be installed now"
    _installYay
fi
echo

# Install package

echo ":: Installing ml4w-hyprland"

# share
sudo rm -rf /usr/share/ml4w-hyprland
sudo cp -r $repo/share/. /usr/share/ml4w-hyprland
echo ":: share installed"

# lib
sudo rm -rf /usr/lib/ml4w-hyprland
sudo cp -r $repo/lib/. /usr/lib/ml4w-hyprland
echo ":: lib installed"

# bin
sudo rm -rf /usr/bin/ml4w-hyprland-setup
sudo cp $repo/bin/ml4w-hyprland-setup /usr/bin/ml4w-hyprland-setup-custom
echo ":: bin installed"


# Start Spinner
gum spin --spinner dot --title "Starting setup now..." -- sleep 3

# Start setup
ml4w-hyprland-setup-custom -p arch
