# Avaris

Welcome! Greed here. This repository contains my personal Nix OS configuration
using Niri(Main).

---

## ✨ Features

This configuration is packed with features to enhance your workflow and
aesthetics:

### 🛠 Installation

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

- Quickshell bar, Wallpapers, settings, themes, all are handled by noctalia or
  other independent shells through their dependent apps.
- Wallpapers apps you can install to manage: Waypaper, utilizing swww as the
  engine.
- Notifications: Handled by Sway Notifications Control (Swaync).
- Audio: Managed through pipewire and wpctl.
- Lock Screen: Uses noctalia lockscreen which displays notifications, music,
  time, weather.
- NVIDIA Drivers: Installed with the latest NVIDIA and AMD drivers. Adjust
  configuration accordingly.

🙏 Credits

- Aeon Remnant
- VimJoyer
