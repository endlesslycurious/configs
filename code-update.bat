REM Install VS.Code extensions listed in code-ext.txt
REM See https://stackoverflow.com/a/163873
for /F "tokens=*" %% EXT in (code-ext.txt) do code --install-extension %%EXT
