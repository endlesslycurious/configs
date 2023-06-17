@echo off

setlocal

REM Check for admin privileges ie ran with gsudo or elevated command line
NET FILE 1>NUL 2>NUL
if ERRORLEVEL 1 (
        echo ERROR: Run script as admin!
        goto :EOF
)

REM Install apps from Microsoft Store via winget
set store=%COMPUTERNAME%-winget.txt

if EXIST %store% (
	echo --- WinGet: Installing from manifest ---
	for /F "tokens=*" %%A in (%store%) do (
		REM WinGet install will upgrade if installed already
		echo -- %%A --
		winget install -e --accept-package-agreements "%%A" 
	)
) else (
	echo No winget file for %COMPUTERNAME%
)

REM update scoop itself
scoop update

REM Install apps from scoop 
set scoop-file=%COMPUTERNAME%-scoop.txt

if EXIST %store% (
	echo --- Scoop: Installing Apps ---
	for /F "tokens=*" %%A in (%scoop-file%) do (
		echo -- %%A --
		scoop install %%A
	)
) else (
	echo No scoop file for %COMPUTERNAME%
)

REM update scoop apps
scoop update --all

REM Update pip if python installed
set piplist=%COMPUTERNAME%-pip.txt

find /C "python" %scoop-file% > NUL
if %ERRORLEVEL% EQU 0 (
	echo --- Python: Update PIP ---
	python3 -m ensurepip --upgrade

	REM Install python modules if list file exists
	if EXIST %piplist% (
		echo --- Python: Installing modules ---
		python3 -m pip install -r %piplist%
	) else (
		echo No Pip file for %COMPUTERNAME%
	)
)

REM Install VS.Code extensions listed in code-ext.txt, generated 
REM by running 'code --list-extensions >> code-ext.txt'
set exts=%COMPUTERNAME%-code-ext.txt

if EXIST %exts% (
	echo --- VS Code: Installing Extensions ---
	for /F "tokens=*" %%E in (%exts%) do (
		code --install-extension %%E
	)
)

REM Copy auto hot key script to startup folder
set dest= "c:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\ctrl-zoom.ahk"

if NOT EXIST %dest% (
	echo --- Diasble ctrl + scroll zooming ---
	copy ctrl-zoom.ahk %dest%
)

echo --- Done! ---
