# Avaris

Welcome! Greed here. This repository contains my personal Nix OS configuration
using Niri(Main) and Hyprland, designed for a clean and efficient workspace.

---

## ✨ Features

This configuration is packed with features to enhance your workflow and
aesthetics:

> **Need help with keybindings?** Just press `Super+Tab' or go to keybinds
> section in noctalia settings to access the keybinding guide on Niri.

---

### 🛠 Installation

> ⚠️ **WARNING**: This setup is intended for **NixOS**. Due to the declarative
> nature of Nix, following these steps will give you an exact copy of my system.

### 1. Clone the repository

```bash
git clone https://github.com/greedoftheendless/Avaris.git
```

### 2. Symlink the .conf files

Not all files are .nix modules. In that case, you can go to the configs folder
and symlink the folder to ~/.config

### 3. Change the user-name

Go to /nixos folder and change the name of user to your wish. Do the same for
home.nix file found in /home folder. Change the name and line in flake.nix's
commented lines.

### 4. Rebuild system

In terminal, type

```bash
sudo nixos-rebuild switch
```

📚 Notes & Integrations

- Quickshell bar, Wallpapers, settings, themes, all are handled by noctalia
  through their dependent apps.
- Wallpapers apps you can install to manage: Waypaper, utilizing swww and
  mpvpaper as the engine.
- Notifications: Handled by Sway Notifications Control (Swaync).
- Audio: Managed through pavucontrol and wpctl.
- Lock Screen: Uses noctalia lockscreen which displays notifications, music,
  time, weather, etc... Hyprlock is used as backup(in case you need to flex 😏.
- NVIDIA Drivers: Installed with the latest NVIDIA and AMD drivers. Adjust
  configuration accordingly.

🙏 Credits

Inspired by and based on the incredible work from:

- Hyprland Wiki
- r/unixporn
- Aeon Remnant
- VimJoyers Discord community (A big-ass community that made Nix fun, and helped
  me to learn)

And many others — your contributions are never forgotten! 📝 To-Do List

- Create a Bash script to automate the installation process for new-NixOS users.

- Transition all .config setups to Nix modules for easier management.

Stay hungry, stay foolish. Keep customizing!
