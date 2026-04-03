# 🏠 Home Manager Configuration

Welcome to the Home Manager configuration directory! This folder contains all user-specific settings, packages, and application configurations for your NixOS system.

## 📁 Directory Structure

### 🔧 Core Files

- **`home.nix`** - Main Home Manager configuration file that imports and orchestrates all modules
- **`home-packages.nix`** - User-level packages and dependencies installed via Home Manager
- **`fish.nix`** - Fish shell configuration (aliases, functions, environment variables)

### 📦 Modules (`/modules`)

Individual application and tool configurations. Each module manages a specific application's settings:

#### 🎨 UI & Terminal
- **`cursor.nix`** - Cursor theme and pointer configuration
- **`starship.nix`** - Modern shell prompt styling and customization
- **`kitty/`** - Terminal emulator configuration with themes and keybindings
- **`cava/`** - Audio visualizer with custom themes and shaders

#### ✏️ Development & Editors
- **`nvf.nix`** - Neovim configuration with plugins and keymaps
- **`zed.nix`** - Zed code editor setup

#### 🛠️ Utilities & Tools
- **`fastfetch/`** - System information display tool configuration
- **`webapp/`** - Web application installer and uninstaller utilities
- **`podman/`** - Container management (home-manager specific settings)

## 🚀 How It Works

1. `home.nix` is the entry point that imports all configuration modules
2. Each module in `/modules` contains settings for a specific application
3. Modules with folders (e.g., `kitty/`, `cava/`) contain additional config files, themes, or assets
4. Standalone `.nix` files (e.g., `cursor.nix`, `starship.nix`) are simple module files with no dependencies

## ⚙️ Adding New Modules

To add a new application:

1. Create a new `.nix` file in `/modules` or a new folder if you need additional assets
2. Define the module configuration using Home Manager options
3. Import it in `home.nix` under the `imports` array

Example:
```nix
imports = [
  ./modules/your-app.nix
];
```

## 🔄 Applying Changes

After modifying any configuration:

```bash
home-manager switch --flake ~/dotfiles
```

## 📝 Notes

- All configurations are declarative and reproducible
- Removing a module will cleanly remove its configurations on next rebuild
