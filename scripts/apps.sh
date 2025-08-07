#!/bin/bash
# https://github.com/PiercingXX

username=$(id -u -n 1000)
builddir=$(pwd)


# Checks for active network connection
if [[ -n "$(command -v nmcli)" && "$(nmcli -t -f STATE g)" != connected ]]; then
    awk '{print}' <<<"Network connectivity is required to continue."
    exit
fi

echo "Updating"
sudo apt update && upgrade -y
wait

# Create Directories if needed
    # font directory
        if [ ! -d "$HOME/.fonts" ]; then
            mkdir -p "$HOME/.fonts"
        fi
        chown -R "$username":"$username" "$HOME"/.fonts
    # Background and Profile Image Directories
        if [ ! -d "$HOME/$username/Pictures/backgrounds" ]; then
            mkdir -p /home/"$username"/Pictures/backgrounds
        fi
        chown -R "$username":"$username" /home/"$username"/Pictures/backgrounds
        if [ ! -d "$HOME/$username/Pictures/profile-image" ]; then
            mkdir -p /home/"$username"/Pictures/profile-image
        fi
        chown -R "$username":"$username" /home/"$username"/Pictures/profile-image
    # Make Trash if not exists
        mkdir --parents ~/.local/share/Trash/files
        ln --symbolic ~/.local/share/Trash/files ~/.trash

# Installing important things && stuff && some dependencies
    echo "Installing Programs and Drivers"
    sudo apt install cups -y
    sudo apt install seahorse -y
    sudo apt install rename -y
    sudo apt install gnome-calculator -y
    wait
    flatpak install flathub org.libreoffice.LibreOffice -y
    flatpak install https://flathub.org/beta-repo/appstream/org.gimp.GIMP.flatpakref -y
    flatpak install flathub org.gnome.SimpleScan -y
    flatpak install flathub org.qbittorrent.qBittorrent -y
    flatpak install flathub io.missioncenter.MissionCenter -y
    flatpak install flathub com.github.tchx84.Flatseal -y

# Nvim & Depends
    sudo apt install neovim -y
    sudo apt install python3-pip -y
    sudo apt install lua5.4 -y

# Synology Drive
    wget "https://global.download.synology.com/download/Utility/SynologyDriveClient/3.4.0-15724/Ubuntu/Installer/synology-drive-client-15724.x86_64.deb"
    wait
    sudo dpkg -i synology-drive-client-15724.x86_64.deb
    wait
    rm synology-drive-client-15724.x86_64.deb
    sudo apt --fix-broken install -y

## Tailscale
    curl -fsSL https://tailscale.com/install.sh | sh
    wait

# Overkill is underrated 
    sudo apt update && upgrade -y
    wait
    sudo apt full-upgrade -y
    wait
    sudo apt install -f
    wait
    sudo dpkg --configure -a
    sudo apt --fix-broken install -y
    wait
    sudo apt autoremove -y
    sudo apt update && upgrade -y
    wait
    flatpak update -y