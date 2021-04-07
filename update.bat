echo --- List outdated packages ---
choco outdated

echo --- Installing from manifest ---
choco install Chocolatey.config -y

echo --- Pinning Python versions ---
choco pin add -n=python
choco pin add -n=python3

echo --- Upgrading outdated packages ---
choco upgrade all -y

echo --- Delete temp install files ---
rmdir /Q /S C:\Users\dpbrown\AppData\Local\Temp\chocolatey

echo --- Install Python modules ---
pip install -r python-modules.txt

echo --- Done! ---
