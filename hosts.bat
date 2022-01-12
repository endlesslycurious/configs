@echo off

setlocal

REM Check for admin privileges ie ran with gsudo
NET FILE 1>NUL 2>NUL
if ERRORLEVEL 1 (
	echo ERROR: Run script as admin!
	goto :EOF
)

set hostfile=C:\Windows\System32\drivers\etc\hosts
echo Checking %hostfile%

REM Loop through hosts in input text file
for /F "tokens=*" %%A in (hosts.txt) do (

	REM Check if site is already in hosts file
	find /C "%%A" %hostfile% > NUL
	
	REM Map site to localhost if its not in file
	if ERRORLEVEL 1 (
		echo Inserting %%A
		echo 127.0.0.1 %%A >> %hostfile%
	) else (
		echo Found %%A
	)
)
