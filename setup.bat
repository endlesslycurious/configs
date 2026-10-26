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

REM Configuring git to use delta (.gitconfig is not symlinked, so set keys individually)
git config --global core.pager "delta"
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.dark true
git config --global merge.conflictStyle zdiff3
