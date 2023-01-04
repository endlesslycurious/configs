@echo off

setlocal

REM Install VS.Code extensions listed in code-ext.txt, generated 
REM by running 'code --list-extensions >> code-ext.txt'

set exts=%COMPUTERNAME%-code-ext.txt

if EXIST %exts% (
	REM Install app named on each line of file
	for /F "tokens=*" %%E in (%exts%) do (
		code --install-extension %%E
	)
)
