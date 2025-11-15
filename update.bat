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

REM If VS.Code is installed..
WHERE code.exe >nul 2>nul
IF %ERRORLEVEL% EQU 0 (
	REM Install VS.Code extensions listed in code-ext.txt, generated 
	REM by running 'code --list-extensions >> code-ext.txt'	
	set exts=vscode/%COMPUTERNAME%-code-ext.txt

	if NOT EXIST %exts% (
		REM use default if no machine specific exists
		set exts=vscode/code-ext.txt
	)

	if EXIST %exts% (
		echo --- VS Code: Installing Extensions ---
		for /F "tokens=*" %%E in (%exts%) do (
			code --install-extension %%E
		)
	) else (
		echo --- No code-ext file for %COMPUTERNAME% ---
	)
)

echo --- Done! ---
