REM Install VS.Code extensions listed in code-ext.txt, generated 
REM by running 'code --list-extensions >> code-ext.txt'

REM Processing text file in batch - https://stackoverflow.com/a/163873
for /F "tokens=*" %%E in (code-ext.txt) do (
	code --install-extension %%E
)
