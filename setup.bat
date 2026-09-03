REM setup symbolic links to config files
@ECHO OFF
@SETLOCAL

REM Configuring NEOVIM
set target=%HOMEDRIVE%%HOMEPATH%\AppData\Local\nvim
if exist %target% del %target%
mklink /D %target% %CD%\nvim\

REM Configuring VIM
set target=%HOMEDRIVE%%HOMEPATH%\_vimrc
if exist %target% del %target%
mklink %target% %CD%\vim\.vimrc

REM Install VIM PLUGin manager, see https://github.com/junegunn/vim-plug
powershell -Command "iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | ni $HOME/vimfiles/autoload/plug.vim -Force"

REM Configuring Zed
set target="%APPDATA%\Zed\settings.json"
if exist %target% del %target%
mklink %target% %CD%\zed\settings.json
