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

REM Update pip if python installed
set piplist=pip/%COMPUTERNAME%.txt

if NOT EXIST %piplist% (
	REM use default if no machine specific exists
	set piplist=pip/default.txt
)

find /C "Python" %store% > NUL
if %ERRORLEVEL% EQU 0 (
	echo --- Python: Update PIP ---
	python -m ensurepip --upgrade

	REM Install python modules if list file exists
	if EXIST %piplist% (
		echo --- Python: Installing modules ---
		python -m pip install -r %piplist%
	) else (
		echo --- No Pip file for %COMPUTERNAME% ---
	)
)

echo --- Done! ---
