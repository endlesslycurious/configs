REM setup symbolic links to config files
@ECHO OFF
@SETLOCAL

REM VIM
set target=%HOMEDRIVE%%HOMEPATH%\_vimrc 
if exist %target% del %target%
mklink %target% %CD%\.vimrc

REM Sublime 3
set target="%APPDATA%\Sublime Text 3\Packages\User\Preferences.sublime-settings" 
if exist %target% del %target%
mklink %target% %CD%\Sublime3.sublime-settings

REM VS Code
set target="%APPDATA%\Code\User\settings.json" 
if exist %target% del %target%
mklink %target% %CD%\VSCode.json

REM Chocolatey
set target=%HOMEDRIVE%%HOMEPATH%\choco.config 
if exist %target% del %target%
mklink %target% %CD%\Chocolatey.config
