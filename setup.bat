REM setup symbolic links to config files
@ECHO OFF
@SETLOCAL

REM Configuring NEOVIM
set target=%HOMEDRIVE%%HOMEPATH%\AppData\Local\nvim
REM rmdir, not del: del follows a directory symlink and deletes the link target's contents
if exist %target% rmdir %target%
mklink /D %target% %CD%\nvim\

REM Configuring Zed
set target="%APPDATA%\Zed\settings.json"
if exist %target% del %target%
mklink %target% %CD%\zed\settings.json

REM Configuring lazygit
if not exist "%LOCALAPPDATA%\lazygit" mkdir "%LOCALAPPDATA%\lazygit"
set target="%LOCALAPPDATA%\lazygit\config.yml"
if exist %target% del %target%
mklink %target% %CD%\lazygit\config.yml

REM Configuring herdr
if not exist "%APPDATA%\herdr" mkdir "%APPDATA%\herdr"
set target="%APPDATA%\herdr\config.toml"
if exist %target% del %target%
mklink %target% %CD%\herdr\config.toml
where herdr >nul 2>&1 && herdr server reload-config >nul 2>&1

REM Configuring agent instructions
if not exist "%USERPROFILE%\.config\opencode" mkdir "%USERPROFILE%\.config\opencode"
if not exist "%USERPROFILE%\.claude" mkdir "%USERPROFILE%\.claude"
if exist "%USERPROFILE%\.config\opencode\AGENTS.md" del "%USERPROFILE%\.config\opencode\AGENTS.md"
if exist "%USERPROFILE%\.claude\CLAUDE.md" del "%USERPROFILE%\.claude\CLAUDE.md"
mklink "%USERPROFILE%\.config\opencode\AGENTS.md" "%CD%\agents\README.md"
mklink "%USERPROFILE%\.claude\CLAUDE.md" "%CD%\agents\README.md"

REM Configuring Windows Terminal colour schemes
set wt_fragment=%LOCALAPPDATA%\Microsoft\Windows Terminal\Fragments\Catppuccin
if not exist "%wt_fragment%" mkdir "%wt_fragment%"
copy /Y "%CD%\cmd\windows-terminal\catppuccin.json" "%wt_fragment%\catppuccin.json" >nul

REM Themes and defaults need a JSONC-aware settings.json merge; schemes above work without it
py -3 --version >nul 2>&1
if not errorlevel 1 (
    py -3 "%CD%\cmd\apply-windows-terminal.py"
    goto :wt_done
)
python --version >nul 2>&1
if not errorlevel 1 (
    python "%CD%\cmd\apply-windows-terminal.py"
    goto :wt_done
)
echo WARNING: Python not found; installed Windows Terminal schemes but not themes/defaults.
:wt_done

REM Set the clink oh-my-posh prompt to Catppuccin Latte
where clink >nul 2>&1
if errorlevel 1 goto :clink_done
set "posh_theme=%LOCALAPPDATA%\Programs\oh-my-posh\themes\catppuccin_latte.omp.json"
if defined POSH_THEMES_PATH set "posh_theme=%POSH_THEMES_PATH%\catppuccin_latte.omp.json"
clink set ohmyposh.theme "%posh_theme%"
:clink_done

REM Configuring git to use delta (.gitconfig is not symlinked, so set keys individually)
set deltaTheme=%CD%\delta\catppuccin.gitconfig
git config --global --get-all include.path | findstr /i /c:"catppuccin.gitconfig" >nul || git config --global --add include.path "%deltaTheme%"
git config --global core.pager "delta"
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.features "catppuccin-latte"
git config --global --unset-all delta.dark >nul 2>&1
git config --global --unset-all delta.light >nul 2>&1
git config --global merge.conflictStyle zdiff3
