REM setup symbolic links to config files
ECHO OFF

REM VIM
if exist %HOMEDRIVE%%HOMEPATH%\_vimrc del %HOMEDRIVE%%HOMEPATH%\_vimrc
mklink %HOMEDRIVE%%HOMEPATH%\_vimrc %CD%\.vimrc

REM Chocolatey
if exist %HOMEDRIVE%%HOMEPATH%\choco.config del %HOMEDRIVE%%HOMEPATH%\choco.config
mklink %HOMEDRIVE%%HOMEPATH%\choco.config %CD%\Chocolatey.config
