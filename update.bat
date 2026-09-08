@echo off

setlocal

REM Check for admin privileges ie ran with gsudo or elevated command line
NET FILE 1>NUL 2>NUL
if ERRORLEVEL 1 (
        echo ERROR: Run script as admin!
        goto :EOF
)

REM Install apps from Microsoft Store via winget
set store=winget/%COMPUTERNAME%.txt

if NOT EXIST %store% (
	REM use default if no machine specific exists
	set store=winget/default.txt
)

if EXIST %store% (
	echo --- WinGet: Installing from manifest ---
	for /F "tokens=*" %%A in (%store%) do (
		REM WinGet install will upgrade if installed already
		echo -- %%A --
		winget install -e --accept-package-agreements "%%A"
	)
) else (
	echo --- No winget file for %COMPUTERNAME% ---
)


echo --- Done! ---
