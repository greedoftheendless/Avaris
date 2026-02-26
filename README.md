# Avaris, the Latin root of Greed!

Welcome! This repository contains my personal Nix OS configuration using Niri(Main) and Hyprland, designed for a clean and efficient workspace.

If you find this useful, please consider **starring the repository**!

Have an idea for a tweak or an improvement? Feel free to **submit a pull request**.
Enjoy your Nix-ed OS!

---

## ✨ Features

This configuration is packed with features to enhance your workflow and aesthetics:

* 🚀 **Hyprland/Niri** - A powerful and responsive tiling/scrolling Wayland Window Manager.
* 🎨 **Stunning UI** - Beautiful  UI configured and managed by DMS(DankMaterialShell), a beautiful shell manager, which helps you customize your OS to your liking with ease. **Waybar** is also added if you prefer that.
* 🖥️ **Custom Theming** - A bespoke **GTK theme**, custom cursors, and icon sets.
* 🖋️️ **Ghostyy Terminal + Kitty(As backup)** - A sleek and functional terminal configuration.
* 🔒 **Secure & Stylish Lockscreen** - **DMS** lock screen enabled with **Hyprlock** (as backup) provides a seamless lock screen.
* 🌄 **Dynamic Wallpapers** - A wallpaper daemon using `swww` and `mpvpaper`, controlled by a GUI tool called by DMS.
* 🧩 **Smart Workspaces** - Efficient **scratchpads(Hyprland)** and dynamic workspaces for enhanced productivity.
* 🤖 **Multi-Management** - Streamlined control with the `better-control` application(Recommended to use if you prefer not using DMS.
* 🐚 **Fish & Starship** - A powerful **Fish shell+Nu shell** with a visually appealing yet simple **Starship prompt**.
* 🔄 **Auto-Start** - Configured for automatic application and script execution on startup.
* ⚡ **Lightweight & Responsive** - A highly optimized configuration for optimal performance.

> **Need help with keybindings?** Just press `Super+Tab' or go to keybinds section in DMS settings  to access the keybinding guide on Niri.

---

### 🛠 Installation

> ⚠️ **WARNING**: This setup is intended for **NixOS**. Due to the declarative nature of Nix, following these steps will give you an exact copy of my system.

### 1. Clone the repository

```bash
    git clone git@github.com:greedoftheendless/Avaris.git
```

### 2. Symlink the .conf files
Not all files are .nix modules. In that case, you can go to the configs folder and symlink the folder to ~/.config

### 3. Change the user-name
Go to /nixos folder and change the name of user to your wish. Do the same for home.nix file found in /home folder. Change the name and line in flake.nix's commented lines.

### 4. Rebuild system
In terminal, type 

```bash
sudo nixos-rebuild switch
```

📚 Notes & Integrations

* Quickshell bar, Wallpapers, settings, themes, all are handled by DMS through their dependet apps.
*   Wallpapers apps you can install to manag: Waypaper, utilizing swww and mpvpaper as the engine.
*   Notifications: Handled by Sway Notifications Control (Swaync).
*   Audio: Managed through pavucontrol and wpctl.
*   Lock Screen: Uses DMS lockscreen which displays notifications, music, time, weather, etc... Hyprlock is used as backup(in case you need to flex 😏.
*   Auto-Start: Configured in '$HOME/.config/hypr/hyprland.conf' '~/dotfiles/configs/hypr/hyprland.conf' under the exec lines and in the configuration file of '~/.config/niri' '~/dotfiles/configs/niri/config.kdl' under STARTUP.
*   Scratchpads (for Hyprland): Configured for quick access to terminals, music, and notes.
*   NVIDIA Drivers: Installed with the latest NVIDIA and AMD drivers. Adjust configuration accordingly.
*   Waybar: Highly modular, supporting various modules for battery, Wi-Fi, media players, and more.
*   Rofi/Vicinae: Rofi offers application search, SSH connections, and terminal/file selection. Vicinae provides similar features plus more — see Vicinae Docs

🙏 Credits

Inspired by and based on the incredible work from:

*   Hyprland Wiki
*   r/unixporn
*   Aeon Remnant (for convincing me to join Nix and use it.)
*   The VimJoyers Discord community (A big-ass community that made Nix fun, and helped me to learn)

And many others — your contributions are never forgotten!
📝 To-Do List

*   Create a Bash script to automate the installation process for new-NixOS users.

*   Transition all .config setups to Nix modules for easier management.

Stay hungry, stay foolish. Keep customizing!


  -Greed
