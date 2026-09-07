REM setup symbolic links to config files
@ECHO OFF
@SETLOCAL

REM Configuring NEOVIM
set target=%HOMEDRIVE%%HOMEPATH%\AppData\Local\nvim
if exist %target% del %target%
mklink /D %target% %CD%\nvim\

REM Configuring Zed
set target="%APPDATA%\Zed\settings.json"
if exist %target% del %target%
mklink %target% %CD%\zed\settings.json
