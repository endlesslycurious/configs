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
		REM Check if app is installed first
		winget list -e -q "%%A" > NUL

		if %ERRORlEVEL% NEQ 1 (
			echo -- Installing %%A --
			winget install -e -q "%%A" --accept-package-agreements
		)
	)
) else (
	echo No winget file for %COMPUTERNAME%
)

REM Install apps from chocolatey manifest if it exists
set manifest=%COMPUTERNAME%-choco.config

if EXIST %manifest% (
	echo --- Choco: Installing from manifest ---
	choco install %manifest% -y
) else (
	echo No Choco config for %COMPUTERNAME%
)

REM Pin Python versions if python installed
find /C "python" %manifest% > NUL
if %ERRORLEVEL% EQU 0 (
	echo --- Choco: Pinning Python versions ---
	choco pin add -n=python3
)

REM Upgrade apps installed by chocolatey
echo --- Choco: Upgrading outdated packages ---
choco upgrade all -y

REM Clean up temp install file cache
set temp=C:\Users\%USERNAME%\AppData\Local\Temp\chocolatey

if EXIST %temp% (
	echo --- Choco: Delete temp install files ---
	rmdir /Q /S C:\Users\%USERNAME%\AppData\Local\Temp\chocolatey
)

REM Update pip if python installed
set piplist=%COMPUTERNAME%-pip.txt

find /C "python" %manifest% > NUL
if %ERRORLEVEL% EQU 0 (
	echo --- Python: Update PIP ---
	python.exe -m ensurepip --upgrade

	REM Install python modules if list file exists
	if EXIST %piplist% (
		echo --- Python: Installing modules ---
		pip install -r %piplist%
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
