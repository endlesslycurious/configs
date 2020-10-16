echo --- List outdated packages ---
choco outdated

echo --- Upgrading outdated packages ---
choco upgrade all -y

echo --- Installing from manifest ---
choco install Chocolatey.config -y

echo --- Delete temp install files ---
rmdir /Q /S C:\Users\dpbrown\AppData\Local\Temp\chocolatey

echo --- Done! ---
