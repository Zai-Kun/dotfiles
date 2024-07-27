1. just install arch however you like
2. chroot into your fresh arch and run:
    1. `sudo pacman -Syu mesa-amber qt5-wayland qt6-wayland zoxide noto-fonts-cjk p7zip noto-fonts-emoji base-devel networkmanager network-manager-applet pipewire pavucontrol waybar bemenu-wayland foot wireguard-tools gnome-keyring git resolvconf xorg-xwayland mako cliphist github-cli stow sway zsh nodejs npm slurp grim thunar polkit xdg-desktop-portal xdg-desktop-portal-wlr vlc ttf-cascadia-code-nerd`
    2. `cd /tmp && git clone https://aur.archlinux.org/paru-bin.git && cd paru-bin && makepkg -si && paru -S wl-clip-persist-git catppuccin-gtk-theme-mocha papirus-folders-catppuccin-git`
3. exit and reboot your system and run:
    `sudo systemctl enable --now NetworkManager.service && sudo systemctl enable --now systemd-resolved.service`
4. to load up the config:
    `cd ~/ && git clone https://github.com/Zai-Kun/dotfiles && cd dotfiles && git submodule init&&git submodule update --depth=1&&stow -v .`
