# VS Code Profiles

This folder stores two VS Code profiles:

- **Home.vscode-profile**  
  Python + Go + C++ (clang/CMake/Makefiles), official ChatGPT integration.

- **Work.vscode-profile**  
  Python + Go + C++ (MSVC / Visual Studio generator), Copilot only, and `*.build → xml` association.

---

## Installing on a new machine

1. Open VS Code.  
2. Open the **Profile** menu.  
3. Choose **Import Profile…**.  
4. Select `Home.vscode-profile` or `Work.vscode-profile`.  
5. Switch to that profile.

VS Code will automatically install the extensions and apply the settings defined in the exported profile.

---

## Updating a profile

1. Switch to the profile you want to update (**Home** or **Work**).  
2. Make changes (settings, extensions, keybindings).  
3. Use **Profiles: Export Profile** from the Command Palette.  
4. Export over the existing file:

```
Home.vscode-profile
Work.vscode-profile
```

5. Commit the updated file to Git.

**Do not manually edit** the `.vscode-profile` files — the exported files are the single source of truth.

---

## Font dependency

Both profiles expect **JetBrainsMono Nerd Font** to be installed.

### macOS:
```
brew install --cask font-jetbrains-mono-nerd-font
```

### Windows:
```
winget install NerdFonts.JetBrainsMono
```

---

## Theme dependency

Both profiles use:

- Catppuccin Latte theme  
- Catppuccin Latte icon theme  

Theme extensions are installed automatically when you import a profile.

---

## LLM usage

- **Home** uses the official **OpenAI / ChatGPT** extension (no stored keys).  
- **Work** uses **GitHub Copilot** (no stored keys).  
- Keep LLM integrations separated by profile.

---
## Profile Creation

This was done on Mac OS, so Mac paths for VS Code files.

### VS Code Clean up
With VS Code **closed**, delete settings folders/files to get a clean install:
```
rm -rf ~/.vscode/extensions
rm -rf ~/Library/Application\ Support/Code/User
rm -rf ~/Library/Application\ Support/Code/CachedData
rm -rf ~/Library/Application\ Support/Code/WorkspaceStorage
rm -rf ~/Library/Application\ Support/Code/logs
```

### Create profile
1. Profiles → Create Profile → Empty → name Home.
2. Switch to Home.
3. Install extensions via CLI see `Home-ext.txt`.
4. Press ⌘⇧P, then Type `Preferences: Open Settings (JSON)` → press Return.
5. Paste the settings into the JSON file from `Home-Settings.json`, then save file.
6. You'll probably get asked to reload.

### Export Pofile
1. In Profiles dialog, select Profile e.g `Home`.
2. Right click and choose `Export` then `Local file`.
3. Select target location and press `Save` button.
4. You may be asked to confirm overwrite of existing file.
5. Submit to version control.